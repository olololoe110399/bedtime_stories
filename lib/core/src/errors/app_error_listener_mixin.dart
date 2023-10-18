import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin AppErrorListenerMixin<T extends StatefulHookConsumerWidget,
        S extends BaseState, P extends ProviderListenable<WrapState<S>>>
    on BasePageStateDelegete<T, S, P> implements AppErrorListener {
  @override
  void onNoInternet(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    ref
        .read(appNavigatorProvider)
        .showErrorSnackBar(message: appExceptionWrapper.appError.message);
  }

  @override
  void onUncaugth(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    ref
        .read(appNavigatorProvider)
        .showErrorSnackBar(message: appExceptionWrapper.appError.message);
  }

  @override
  void onServerError(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    ref
        .read(appNavigatorProvider)
        .showErrorSnackBar(message: appExceptionWrapper.appError.message);
  }

  @override
  void onRefreshTokenFail(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    ref.read(appNavigatorProvider).replaceAll([const StartRoute()]);
  }
}
