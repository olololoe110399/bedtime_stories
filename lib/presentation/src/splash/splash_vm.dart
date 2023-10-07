import 'dart:async';

// import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
// import 'package:safe_device/safe_device.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'splash_event.dart';
import 'splash_state.dart';

final splashVMProvider =
    StateNotifierProvider.autoDispose<SplashVM, WrapState<SplashState>>(
  (ref) => SplashVM(ref),
);

class SplashVM extends BaseVM<SplashEvent, SplashState> {
  SplashVM(Ref ref) : super(const SplashState(), ref) {
    Future.microtask(
      () {
        add(const SplashEventLoaded());
      },
    );
  }

  @override
  void add(SplashEvent event) {
    switch (event) {
      case SplashEventLoaded event:
        onSplashEventLoaded(event);
      case SplashEventTextChanged event:
        onSplashEventTextChanged(event);
        // Add More Event here
        break;
      default:
    }
  }

  Future<bool> checkJailbreakStatus() async {
    bool jailbrokenOrRooted = false;
    // try {
    //   jailbrokenOrRooted = await FlutterJailbreakDetection.jailbroken ||
    //       !await SafeDevice.isSafeDevice;
    // } catch (e) {
    //   jailbrokenOrRooted = true;
    // }
    return jailbrokenOrRooted;
  }

  Future<void> onSplashEventLoaded(
    SplashEventLoaded event,
  ) async {
    Future.delayed(const Duration(seconds: 2))
        .then((_) => checkJailbreakStatus())
        .then(
      (isJailBreak) {
        if (isJailBreak) {
          navigator.popAndPush(
            const JailbreakRoute(),
          );
        } else {
          navigator.popAndPush(
            const StartRoute(),
          );
        }
      },
    );
  }

  Future<void> onSplashEventTextChanged(
    SplashEventTextChanged event,
  ) async {
    // TODO: Implement SplashEventTextChanged
  }
}
