import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState extends BaseState with _$HistoryState {
  const factory HistoryState({
    @Default(<Story>[]) List<Story> stories,
    // Add More State here
  }) = _HistoryState;
}
