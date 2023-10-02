import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'define_story_event.freezed.dart';

@freezed
class DefineStoryEvent extends BaseEvent with _$DefineStoryEvent {
  
  const factory DefineStoryEvent.loaded(
    bool loading,
  ) = DefineStoryEventLoaded;

  const factory DefineStoryEvent.textChanged(
    String text,
  ) = DefineStoryEventTextChanged;

  // Add More Events here
}
