import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseVM<E extends BaseEvent, S extends BaseState>
    extends BaseVMDelegete<E, S> with BaseVMMixin {
  BaseVM(S initialState, Ref ref) : super(initialState, ref);
}

abstract class BaseVMDelegete<E extends BaseEvent, S extends BaseState>
    extends StateNotifier<WrapState<S>> with LogMixin {
  BaseVMDelegete(
    S initialState,
    Ref ref,
  ) : super(WrapState(data: initialState)) {
    this.navigator = ref.watch(appNavigatorProvider);
  }
  late final AppNavigator navigator;

  S get dataState => super.state.data;

  void add(E event);

  @override
  set state(WrapState<S> value) {
    if (mounted) {
      super.state = value;
    } else {
      logD('Cannot set state when widget is not mounted');
    }
  }

  void emit(WrapState<S> newState) {
    state = newState;
  }

  void emitData(S newDataState) {
    state = state.copyWith(data: newDataState);
  }

  void showLoading() {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
  }

  void hideLoading() {
    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }

  void addException(AppExceptionWrapper appExceptionWrapper) {
    emit(
      state.copyWith(
        appExceptionWrapper: appExceptionWrapper,
      ),
    );
  }
}
