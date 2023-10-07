import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent extends BaseEvent with _$SplashEvent {
  const factory SplashEvent.loaded() = SplashEventLoaded;

  const factory SplashEvent.textChanged(
    String text,
  ) = SplashEventTextChanged;

  // Add More Events here
}
