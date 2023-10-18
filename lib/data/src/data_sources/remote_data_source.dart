import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:dart_openai/dart_openai.dart';

abstract class RemoteDataSource {
  Stream<OpenAIStreamChatCompletionModel> completion({
    required String model,
    required int maxTokens,
    required double temperature,
    required List<MessageModel> messages,
  });
}

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final RestNonAuthClient client;

  RemoteDataSourceImpl({required this.client});

  @override
  Stream<OpenAIStreamChatCompletionModel> completion({
    required String model,
    required int maxTokens,
    required double temperature,
    required List<MessageModel> messages,
  }) =>
      OpenAI.instance.chat.createStream(
        model: model,
        messages: messages
            .map(
              (e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.role == 'user'
                    ? OpenAIChatMessageRole.user
                    : OpenAIChatMessageRole.system,
                content: e.content ?? "",
              ),
            )
            .toList(),
        maxTokens: maxTokens,
        temperature: temperature,
      );
}
