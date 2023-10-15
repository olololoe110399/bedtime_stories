import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_detail_event.freezed.dart';

@freezed
class StoryDetailEvent extends BaseEvent with _$StoryDetailEvent {
  const factory StoryDetailEvent.loaded() = StoryDetailEventLoaded;

  // Add More Events here
}
