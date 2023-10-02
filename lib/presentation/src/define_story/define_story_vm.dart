import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'define_story_event.dart';
import 'define_story_state.dart';

final defineStoryVMProvider = StateNotifierProvider.autoDispose<
    DefineStoryVM, WrapState<DefineStoryState>>(
  (ref) => DefineStoryVM(ref),
);

class DefineStoryVM
    extends BaseVM<DefineStoryEvent, DefineStoryState> {
  DefineStoryVM(Ref ref) : super(const DefineStoryState(), ref);

  @override
  void add(DefineStoryEvent event) {
    switch (event.runtimeType) {
      case DefineStoryEventLoaded:
        onDefineStoryEventLoaded(event as DefineStoryEventLoaded);
        case DefineStoryEventTextChanged:
        onDefineStoryEventTextChanged(event as DefineStoryEventTextChanged);
         // Add More Event here
        break;
      default:
    }
  }


  Future<void> onDefineStoryEventLoaded(
    DefineStoryEventLoaded event,
  ) async {
    // TODO: Implement DefineStoryEventLoaded
  }

  Future<void> onDefineStoryEventTextChanged(
    DefineStoryEventTextChanged event,
  ) async {
    // TODO: Implement DefineStoryEventTextChanged
  }

}
