import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_detail_state.freezed.dart';

@freezed
class StoryDetailState extends BaseState with _$StoryDetailState {
  const factory StoryDetailState({
    @Default(null) Story? story,
    @Default(1.0) double volume,
    @Default(0.8) double pitch,
    @Default(0.5) double speechRate,
    @Default(null) List<String>? languages,
    @Default("en-US") String langCode,
    @Default(false) bool isSpeaking,
  }) = _StoryDetailState;
}
