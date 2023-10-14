import 'package:bedtime_stories/data/src/models/chat_completion_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_request_model.freezed.dart';
part 'chat_request_model.g.dart';

@freezed
class ChatRequestModel with _$ChatRequestModel {
  const factory ChatRequestModel({
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'max_tokens') int? maxTokens,
    @JsonKey(name: 'temperature') double? temperature,
    @JsonKey(name: 'messages') List<MessageModel>? messages,
  }) = _ChatRequestModel;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestModelFromJson(json);
}
