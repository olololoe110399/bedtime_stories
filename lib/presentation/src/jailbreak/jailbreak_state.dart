import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jailbreak_state.freezed.dart';

@freezed
class JailbreakState extends BaseState with _$JailbreakState {
  const factory JailbreakState() = _JailbreakState;
}
