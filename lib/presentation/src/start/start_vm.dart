import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:bedtime_stories/presentation/presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';

final startVMProvider =
    StateNotifierProvider.autoDispose<StartVM, WrapState<StartState>>(
  (ref) => StartVM(
    ref,
    initDatabaseStoryUsecase: GetIt.instance.get<InitDatabaseStoryUsecase>(),
  ),
);

class StartVM extends BaseVM<StartEvent, StartState> {
  StartVM(
    Ref ref, {
    required this.initDatabaseStoryUsecase,
  }) : super(const StartState(), ref) {
    Future.microtask(
      () => add(const StartEvent.loaded()),
    );
  }

  final InitDatabaseStoryUsecase initDatabaseStoryUsecase;

  @override
  void add(StartEvent event) {
    switch (event) {
      case StartEventLoaded event:
        onStartEventLoaded(event);
        break;
      default:
    }
  }

  Future<void> onStartEventLoaded(
    StartEventLoaded event,
  ) async {
    await initDatabaseStoryUsecase.call(unit);
  }
}
