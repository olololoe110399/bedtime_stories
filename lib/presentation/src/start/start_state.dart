import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_state.freezed.dart';

@freezed
class StartState extends BaseState with _$StartState {
  const factory StartState({
    @Default(false) bool loading, 
    String? text,
     // Add More State here
  }) = _StartState;
}
