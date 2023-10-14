import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completion.freezed.dart';

@freezed
class ChatCompletion with _$ChatCompletion {
  const factory ChatCompletion({
    @Default(ChatCompletion.defaultId) String id,
    @Default(ChatCompletion.defaultObject) String object,
    @Default(ChatCompletion.defaultCreated) int created,
    @Default(ChatCompletion.defaultModel) String model,
    @Default(ChatCompletion.defaultChoices) List<Choice> choices,
    @Default(ChatCompletion.defaultUsage) Usage usage,
  }) = _ChatCompletion;

  static const defaultId = "chatcmpl-123";
  static const defaultObject = "chat.completion";
  static const defaultCreated = 1677652288;
  static const defaultModel = "gpt-3.5-turbo-0613";
  static const List<Choice> defaultChoices = [];
  static const defaultUsage = Usage();
}

@freezed
class Choice with _$Choice {
  const factory Choice({
    @Default(Choice.defaultMessage) Message message,
    @Default(Choice.defaultFinishReason) String finishReason,
    @Default(Choice.defaultIndex) int index,
  }) = _Choice;

  static const defaultIndex = 0;
  static const defaultMessage = Message();
  static const defaultFinishReason = "stop";
}

@freezed
class Message with _$Message {
  const factory Message({
    @Default(Message.defaultRole) String role,
    @Default(Message.defaultContent) String content,
  }) = _Message;

  static const defaultRole = "assistant";
  static const defaultContent = "\n\nHello there, how may I assist you today?";
}

@freezed
class Usage with _$Usage {
  const factory Usage({
    @Default(Usage.defaultPromptTokens) int promptTokens,
    @Default(Usage.defaultCompletionTokens) int completionTokens,
    @Default(Usage.defaultTotalTokens) int totalTokens,
  }) = _Usage;

  static const defaultPromptTokens = 9;
  static const defaultCompletionTokens = 12;
  static const defaultTotalTokens = 21;
}
