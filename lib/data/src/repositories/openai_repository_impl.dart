import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';

import 'package:dartz/dartz.dart';

typedef TaskExcute<T> = Future<T> Function();

@LazySingleton(as: OpenAIRepository)
class OpenAIRepositoryImpl implements OpenAIRepository {
  final OpenAIRemoteDataSource remoteDataSource;
  final ChatCompletionDataMapper chatCompletionDataMapper;
  final MessageDataMapper messageDataMapper;
  final NetworkInfo networkInfo;

  OpenAIRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.chatCompletionDataMapper,
    required this.messageDataMapper,
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

        return chatCompletionDataMapper.mapToEntity(chatCompletion);
      },
    );
  }
}
