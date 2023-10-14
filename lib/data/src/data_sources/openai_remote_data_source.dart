import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';

abstract class OpenAIRemoteDataSource {
  Future<ChatCompletionModel> completion({
    required String model,
    required int maxTokens,
    required double temperature,
    required List<MessageModel> messages,
  });
}

@LazySingleton(as: OpenAIRemoteDataSource)
class OpenAIRemoteDataSourceImpl implements OpenAIRemoteDataSource {
  final RestNonAuthClient client;

  OpenAIRemoteDataSourceImpl({required this.client});

  @override
  Future<ChatCompletionModel> completion({
    required String model,
    required int maxTokens,
    required double temperature,
    required List<MessageModel> messages,
  }) =>
      client.completions(
        'Bearer ${Env.apiKey}',
        ChatRequestModel(
          model: model,
          maxTokens: maxTokens,
          temperature: temperature,
          messages: messages,
        ),
      );
}
