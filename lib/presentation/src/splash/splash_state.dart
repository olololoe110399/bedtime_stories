import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState extends BaseState with _$SplashState {
  const factory SplashState({
    @Default(false) bool loading, 
    String? text,
     // Add More State here
  }) = _SplashState;
}
