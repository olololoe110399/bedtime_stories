import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jailbreak_event.freezed.dart';

@freezed
class JailbreakEvent extends BaseEvent with _$JailbreakEvent {
  const factory JailbreakEvent.initial() = JailbreakEventInitial;

  // Add More Events here
}
