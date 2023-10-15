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
  Future<Result<ChatCompletion>> completion(
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
        if (chatCompletion.choices != null &&
            chatCompletion.choices!.isNotEmpty) {
          if (chatCompletion.choices!.first.message == null) {
            throw Exception('message is null');
          }
          if (chatCompletion.choices!.first.message!.content!.isEmpty) {
            throw Exception('message content is empty');
          }
          final storyModel = StoryHiveModel(
            story: chatCompletion.choices!.first.message!.content!,
            imagePath: '',
          );
          await localDataSource.addStoryItem(storyModel);
        }
        return chatCompletionDataMapper.mapToEntity(chatCompletion);
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
}
