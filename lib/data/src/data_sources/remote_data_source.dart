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

  Future<OpenAIImageModel> createImage({
    required String prompt,
    String? model,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageStyle? style,
    OpenAIImageQuality? quality,
    OpenAIImageResponseFormat? responseFormat,
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
                content: [
                  OpenAIChatCompletionChoiceMessageContentItemModel.text(
                    e.content ?? "",
                  ),
                ],
              ),
            )
            .toList(),
        maxTokens: maxTokens,
        temperature: temperature,
      );

  @override
  Future<OpenAIImageModel> createImage({
    required String prompt,
    int? n = 1,
    OpenAIImageSize? size = OpenAIImageSize.size256,
    OpenAIImageStyle? style = OpenAIImageStyle.vivid,
    OpenAIImageQuality? quality = OpenAIImageQuality.hd,
    OpenAIImageResponseFormat? responseFormat = OpenAIImageResponseFormat.url,
    String? model,
  }) {
    return OpenAI.instance.image.create(
      prompt: prompt,
      model: model,
      n: n,
      size: size,
      style: style,
      quality: quality,
      responseFormat: responseFormat,
    );
  }
}
