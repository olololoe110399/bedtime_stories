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
  Future<Result<Story>> completion(
      {required String model,
      required int maxTokens,
      required double temperature,
      required List<Message> messages}) {
    return handleCommon(
      () async {
        final chatCompletion = await remoteDataSource.completion(
          model: model,
          maxTokens: maxTokens,
          temperature: temperature,
          messages: messageDataMapper.mapToListData(messages),
        );
        if (chatCompletion.choices != null && chatCompletion.choices!.isEmpty) {
          throw Exception('choices is null or empty');
        }

        if (chatCompletion.choices!.first.message == null) {
          throw Exception('message is null');
        }
        if (chatCompletion.choices!.first.message!.content!.isEmpty) {
          throw Exception('message content is empty');
        }
        final String newStory = chatCompletion.choices!.first.message!.content!;

        final imagePrompts = [];
        final storyParagraphs = [];
        final titleStory = [];

        for (final paragraph in newStory.split('\n\n')) {
          if (paragraph.contains('Image Prompt:')) {
            imagePrompts.add(paragraph);
          } else if (paragraph.contains('Title:')) {
            titleStory.add(paragraph);
          } else {
            storyParagraphs.add(paragraph);
          }
        }
        final storyModel = StoryHiveModel(
          story: storyParagraphs.join("\n\n"),
          imagePath: imagePrompts.isNotEmpty ? imagePrompts.first : '',
          title: titleStory.isNotEmpty ? titleStory.first : '',
          microsecondsSinceEpoch: StringUtils.idGenerator(),
        );
        await localDataSource.addStoryItem(storyModel);
        return storyDataMapper.mapToEntity(storyModel);
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
}
