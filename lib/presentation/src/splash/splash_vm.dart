import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'splash_event.dart';
import 'splash_state.dart';

final splashVMProvider =
    StateNotifierProvider.autoDispose<SplashVM, WrapState<SplashState>>(
  (ref) => SplashVM(ref),
);

class SplashVM extends BaseVM<SplashEvent, SplashState> {
  SplashVM(Ref ref) : super(const SplashState(), ref);

  @override
  void add(SplashEvent event) {
    switch (event.runtimeType) {
      case SplashEventLoaded:
        onSplashEventLoaded(event as SplashEventLoaded);
      case SplashEventTextChanged:
        onSplashEventTextChanged(event as SplashEventTextChanged);
        // Add More Event here
        break;
      default:
    }
  }

  Future<void> onSplashEventLoaded(
    SplashEventLoaded event,
  ) async {
    // TODO: Implement SplashEventLoaded
  }

  Future<void> onSplashEventTextChanged(
    SplashEventTextChanged event,
  ) async {
    // TODO: Implement SplashEventTextChanged
  }
}
