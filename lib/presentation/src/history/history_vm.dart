import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'history_event.dart';
import 'history_state.dart';

final historyVMProvider = StateNotifierProvider.autoDispose<
    HistoryVM, WrapState<HistoryState>>(
  (ref) => HistoryVM(ref),
);

class HistoryVM
    extends BaseVM<HistoryEvent, HistoryState> {
  HistoryVM(Ref ref) : super(const HistoryState(), ref);

  @override
  void add(HistoryEvent event) {
    switch (event.runtimeType) {
      case HistoryEventLoaded:
        onHistoryEventLoaded(event as HistoryEventLoaded);
        case HistoryEventTextChanged:
        onHistoryEventTextChanged(event as HistoryEventTextChanged);
         // Add More Event here
        break;
      default:
    }
  }


  Future<void> onHistoryEventLoaded(
    HistoryEventLoaded event,
  ) async {
    // TODO: Implement HistoryEventLoaded
  }

  Future<void> onHistoryEventTextChanged(
    HistoryEventTextChanged event,
  ) async {
    // TODO: Implement HistoryEventTextChanged
  }

}
