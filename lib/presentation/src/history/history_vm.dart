import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'history_event.dart';
import 'history_state.dart';

final historyVMProvider =
    StateNotifierProvider.autoDispose<HistoryVM, WrapState<HistoryState>>(
  (ref) => HistoryVM(
    ref,
    getStoriesStreamUsecase: GetIt.instance.get<GetStoriesStreamUsecase>(),
    initDatabaseStoryUsecase: GetIt.instance.get<InitDatabaseStoryUsecase>(),
  ),
);

class HistoryVM extends BaseVM<HistoryEvent, HistoryState> {
  HistoryVM(
    Ref ref, {
    required this.getStoriesStreamUsecase,
    required this.initDatabaseStoryUsecase,
  }) : super(const HistoryState(), ref) {
    Future.microtask(() {
      add(const HistoryEventLoaded());
    });
  }

  GetStoriesStreamUsecase getStoriesStreamUsecase;
  InitDatabaseStoryUsecase initDatabaseStoryUsecase;

  @override
  void add(HistoryEvent event) {
    switch (event) {
      case HistoryEventLoaded event:
        onHistoryEventLoaded(event);
        break;
      default:
    }
  }

  Future<void> onHistoryEventLoaded(
    HistoryEventLoaded event,
  ) async {
    await initDatabaseStoryUsecase.call(unit);
    getStoriesStreamUsecase
        .call(const GetStoriesStreamParams())
        .listen((event) {
      event.fold(
        (l) => addException(
          AppExceptionWrapper(appError: l),
        ),
        (r) {
          emitData(dataState.copyWith(stories: r));
        },
      );
    }).disposeBy(disposeBag);
  }
}
