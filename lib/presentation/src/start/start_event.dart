import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_event.freezed.dart';

@freezed
class StartEvent extends BaseEvent with _$StartEvent {
  const factory StartEvent.loaded() = StartEventLoaded;

  // Add More Events here
}
