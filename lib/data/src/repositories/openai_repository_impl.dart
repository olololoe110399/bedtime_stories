import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:dartz/dartz.dart';

typedef TaskExcute<T> = Future<T> Function();

@LazySingleton(as: OpenAIRepository)
class OpenAIRepositoryImpl implements OpenAIRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final ChatCompletionDataMapper chatCompletionDataMapper;
  final MessageDataMapper messageDataMapper;
  final StoryDataMapper storyDataMapper;
  final NetworkInfo networkInfo;

  OpenAIRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.chatCompletionDataMapper,
    required this.messageDataMapper,
    required this.storyDataMapper,
  });

  Future<Result<T>> handleCommon<T>(TaskExcute<T> task) async {
    try {
      if (await networkInfo.isConnected) {
        return right(await task());
      } else {
        throw NotInterNetException();
      }
    } catch (error) {
      return left(ErrorMapperFactory.map(error));
    }
  }

  @override
  Stream<Result<Story>> completion({
    required String model,
    required int maxTokens,
    required double temperature,
    required List<Message> messages,
  }) {
    return remoteDataSource
        .completion(
      model: model,
      maxTokens: maxTokens,
      temperature: temperature,
      messages: messageDataMapper.mapToListData(messages),
    )
        .map(
      (event) {
        if (event.choices.isEmpty) {
          throw Exception('choices is empty');
        }
        final String newStory =
            event.choices.first.delta.content?.first.text ?? "";
        final storyModel = StoryHiveModel(
          story: newStory,
          imagePath: '',
          title: '',
          microsecondsSinceEpoch: '',
        );
        return right<AppError, Story>(
          storyDataMapper.mapToEntity(storyModel).copyWith(
                isStop: event.choices.every(
                  (element) => element.finishReason != null,
                ),
              ),
        );
      },
    ).onErrorReturnWith(
      (error, stackTrace) {
        return left<AppError, Story>(ErrorMapperFactory.map(error));
      },
    );
  }

  @override
  Stream<Result<List<Story>>> streamStories() {
    return localDataSource.getStoryList().map((event) {
      return right<AppError, List<Story>>(
          storyDataMapper.mapToListEntity(event));
    }).onErrorReturnWith((error, stackTrace) {
      return left<AppError, List<Story>>(ErrorMapperFactory.map(error));
    });
  }

  @override
  Future<UnitResult> initDatabaseStory() => handleCommon(
        () async {
          await localDataSource.initDatabaseStory();
          return unit;
        },
      );

  @override
  Future<Result<Story>> getStoryById(String id) => handleCommon(
        () async {
          final data = await localDataSource.getStoryItem(id);
          return storyDataMapper.mapToEntity(data);
        },
      );

  @override
  Future<Result<String>> saveStories(Story story) => handleCommon(
        () async {
          if (story.story.isEmpty) {
            throw Exception('Message is empty or null');
          }
          final imagePrompts = [];
          final storyParagraphs = [];
          final titleStory = [];

          for (final paragraph in story.story.split('\n\n')) {
            if (paragraph.contains('Image Prompt:')) {
              imagePrompts.add(paragraph);
            } else if (paragraph.contains('Title:')) {
              titleStory.add(paragraph);
            } else {
              storyParagraphs.add(paragraph);
            }
          }

          final storyModel = storyDataMapper.mapToData(story);
          var storyLocal = storyModel.copyWith(
            story: storyParagraphs.join('\n\n'),
            imagePath: imagePrompts.isEmpty ? '' : imagePrompts.first,
            title: titleStory.isEmpty ? '' : titleStory.first,
            microsecondsSinceEpoch: StringUtils.idGenerator(),
          );

          if ((storyLocal.imagePath ?? '').isNotEmpty) {
            final openAIImageModel = await remoteDataSource.createImage(
              prompt: storyLocal.imagePath ?? '',
            );

            if (openAIImageModel.data.isNotEmpty) {
              storyLocal = storyLocal.copyWith(
                imagePath: openAIImageModel.data.first.url,
              );
            }
          }

          localDataSource.addStoryItem(storyLocal);
          return storyLocal.key;
        },
      );
}
