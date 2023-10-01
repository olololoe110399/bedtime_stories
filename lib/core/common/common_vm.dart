import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final commonVMProvider =
    StateNotifierProvider<CommonVM, WrapState<CommonState>>(
  (ref) => CommonVM(ref),
);

class CommonVM extends BaseVM<CommonEvent, CommonState> {
  CommonVM(Ref ref) : super(const CommonState(), ref);

  @override
  void add(CommonEvent event) {
    if (event is AppThemeChanged) {
      onAppThemeChanged(event);
    }
  }

  Future<void> onAppThemeChanged(
    AppThemeChanged event,
  ) async {
    emitData(
      dataState.copyWith(
        themeMode: event.themeMode,
      ),
    );
  }
}
