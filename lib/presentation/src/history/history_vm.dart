import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'history_event.dart';
import 'history_state.dart';

final historyVMProvider =
    StateNotifierProvider.autoDispose<HistoryVM, WrapState<HistoryState>>(
  (ref) => HistoryVM(
    ref,
    getStoriesStreamUsecase: GetIt.instance.get<GetStoriesStreamUsecase>(),
  ),
);

class HistoryVM extends BaseVM<HistoryEvent, HistoryState> {
  HistoryVM(
    Ref ref, {
    required this.getStoriesStreamUsecase,
  }) : super(const HistoryState(), ref) {
    Future.microtask(() {
      add(const HistoryEventLoaded());
    });
  }

  GetStoriesStreamUsecase getStoriesStreamUsecase;

  @override
  void add(HistoryEvent event) {
    switch (event) {
      case HistoryEventLoaded event:
        onHistoryEventLoaded(event);
        break;
      case HistoryEventSearchChanged event:
        onHistoryEventSearchChanged(event);
        break;
      default:
    }
  }

  Future<void> onHistoryEventLoaded(
    HistoryEventLoaded event,
  ) async {
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

  Future<void> onHistoryEventSearchChanged(
    HistoryEventSearchChanged event,
  ) async {
    emitData(
      dataState.copyWith(searchKey: event.searchKey),
    );
  }
}
