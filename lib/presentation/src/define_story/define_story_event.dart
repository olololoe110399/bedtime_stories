import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'define_story_event.freezed.dart';

@freezed
class DefineStoryEvent extends BaseEvent with _$DefineStoryEvent {
  const factory DefineStoryEvent.loaded() = DefineStoryEventLoaded;

  const factory DefineStoryEvent.textChanged(
    String text,
  ) = DefineStoryEventTextChanged;

  const factory DefineStoryEvent.onPressed({
    required String age,
    required String gender,
    required List<String> characters,
    required String childName,
    required String venue,
    required String language,
    required String inferenceId,
  }) = DefineStoryEventOnPressed;
  const factory DefineStoryEvent.saveStory({
    required Story story,
  }) = DefineStoryEventSaveStory;

  // Add More Events here
}
