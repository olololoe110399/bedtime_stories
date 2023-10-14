import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'define_story_event.dart';
import 'define_story_state.dart';

final defineStoryVMProvider = StateNotifierProvider.autoDispose<DefineStoryVM,
    WrapState<DefineStoryState>>(
  (ref) => DefineStoryVM(
    ref,
    completionUsecase: GetIt.I.get<CompletionUsecase>(),
  ),
);

class DefineStoryVM extends BaseVM<DefineStoryEvent, DefineStoryState> {
  DefineStoryVM(
    Ref ref, {
    required this.completionUsecase,
  }) : super(const DefineStoryState(), ref) {
    Future.microtask(() {
      runCatching<ChatCompletion>(
        completionUsecase.call(
          const CompletionParams(messages: [
            Message(
              content: 'Say this is a test!',
              role: 'user',
            )
          ]),
        ),
        doOnSuccess: (data) {
          logD(data);
        },
        isHandleLoading: false,
      );
    });
  }

  CompletionUsecase completionUsecase;

  @override
  void add(DefineStoryEvent event) {
    switch (event) {
      case DefineStoryEventLoaded event:
        onDefineStoryEventLoaded(event);
      case DefineStoryEventTextChanged event:
        onDefineStoryEventTextChanged(event);
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
