import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'start_event.dart';
import 'start_state.dart';

final startVMProvider =
    StateNotifierProvider.autoDispose<StartVM, WrapState<StartState>>(
  (ref) => StartVM(ref),
);

class StartVM extends BaseVM<StartEvent, StartState> {
  StartVM(Ref ref) : super(const StartState(), ref);

  @override
  void add(StartEvent event) {
    switch (event) {
      case StartEventLoaded event:
        onStartEventLoaded(event);
      case StartEventTextChanged event:
        onStartEventTextChanged(event);
        // Add More Event here
        break;
      default:
    }
  }

  Future<void> onStartEventLoaded(
    StartEventLoaded event,
  ) async {
    // TODO: Implement StartEventLoaded
  }

  Future<void> onStartEventTextChanged(
    StartEventTextChanged event,
  ) async {
    // TODO: Implement StartEventTextChanged
  }
}
