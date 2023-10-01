import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.freezed.dart';

@freezed
class HistoryEvent extends BaseEvent with _$HistoryEvent {
  
  const factory HistoryEvent.loaded(
    bool loading,
  ) = HistoryEventLoaded;

  const factory HistoryEvent.textChanged(
    String text,
  ) = HistoryEventTextChanged;

  // Add More Events here
}
