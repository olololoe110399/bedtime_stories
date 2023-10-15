import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'story_detail_event.dart';
import 'story_detail_state.dart';

final storyDetailVMProvider = StateNotifierProvider.autoDispose
    .family<StoryDetailVM, WrapState<StoryDetailState>, String>(
  (ref, id) => StoryDetailVM(
    ref,
    id: id,
    getStoryByIdUsecase: GetIt.instance.get<GetStoryByIdUsecase>(),
  ),
);

class StoryDetailVM extends BaseVM<StoryDetailEvent, StoryDetailState> {
  StoryDetailVM(
    Ref ref, {
    required this.id,
    required this.getStoryByIdUsecase,
  }) : super(const StoryDetailState(), ref) {
    Future.microtask(
      () {
        add(const StoryDetailEventLoaded());
      },
    );
  }

  String id;

  GetStoryByIdUsecase getStoryByIdUsecase;

  @override
  void add(StoryDetailEvent event) {
    switch (event) {
      case StoryDetailEventLoaded event:
        onStoryDetailEventLoaded(event);
        // Add More Event here
        break;
      default:
    }
  }

  Future<void> onStoryDetailEventLoaded(
    StoryDetailEventLoaded event,
  ) async {
    await runCatching(
      getStoryByIdUsecase.call(GetStoryByIdParams(id: id)),
      doOnSuccess: (story) {
        emitData(dataState.copyWith(story: story));
      },
    );
  }
}
