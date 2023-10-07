import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'jailbreak_event.dart';
import 'jailbreak_state.dart';

final jailbreakVMProvider =
    StateNotifierProvider.autoDispose<JailbreakVM, WrapState<JailbreakState>>(
  (ref) => JailbreakVM(ref),
);

class JailbreakVM extends BaseVM<JailbreakEvent, JailbreakState> {
  JailbreakVM(Ref ref) : super(const JailbreakState(), ref);

  @override
  void add(JailbreakEvent event) {
    switch (event) {
      case JailbreakEventInitial event:
        onJailbreakEventLoaded(event);
        // Add More Event here
        break;
      default:
    }
  }

  Future<void> onJailbreakEventLoaded(
    JailbreakEventInitial event,
  ) async {
    // TODO: Implement JailbreakEventLoaded
  }
}
