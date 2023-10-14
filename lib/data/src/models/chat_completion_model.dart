import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completion_model.freezed.dart';
part 'chat_completion_model.g.dart';

@freezed
class ChatCompletionModel with _$ChatCompletionModel {
  const factory ChatCompletionModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'object') String? object,
    @JsonKey(name: 'created') int? created,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'usage') UsageModel? usage,
    @JsonKey(name: 'choices') List<ChoiceModel>? choices,
  }) = _ChatCompletionModel;

  factory ChatCompletionModel.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionModelFromJson(json);
}

@freezed
class UsageModel with _$UsageModel {
  const factory UsageModel({
    @JsonKey(name: 'prompt_tokens') int? promptTokens,
    @JsonKey(name: 'completion_tokens') int? completionTokens,
    @JsonKey(name: 'total_tokens') int? totalTokens,
  }) = _UsageModel;

  factory UsageModel.fromJson(Map<String, dynamic> json) =>
      _$UsageModelFromJson(json);
}

@freezed
class ChoiceModel with _$ChoiceModel {
  const factory ChoiceModel({
    @JsonKey(name: 'message') MessageModel? message,
    @JsonKey(name: 'finish_reason') String? finishReason,
    @JsonKey(name: 'index') int? index,
  }) = _ChoiceModel;

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);
}

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'content') String? content,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
