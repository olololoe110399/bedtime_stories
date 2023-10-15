import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_detail_state.freezed.dart';

@freezed
class StoryDetailState extends BaseState with _$StoryDetailState {
  const factory StoryDetailState({
    @Default(null) Story? story,
  }) = _StoryDetailState;
}
