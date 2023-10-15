import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_detail_event.freezed.dart';

@freezed
class StoryDetailEvent extends BaseEvent with _$StoryDetailEvent {
  const factory StoryDetailEvent.loaded() = StoryDetailEventLoaded;
  const factory StoryDetailEvent.shared() = StoryDetailEventShared;
  const factory StoryDetailEvent.play() = StoryDetailEventPlay;
  const factory StoryDetailEvent.stop() = StoryDetailEventStoped;

  // Add More Events here
}
