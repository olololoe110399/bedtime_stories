import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin AppErrorListenerMixin<T extends StatefulHookConsumerWidget,
        S extends BaseState, P extends ProviderListenable<WrapState<S>>>
    on BasePageStateDelegete<T, S, P> implements AppErrorListener {
  @override
  void onNoInternet(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    logE(appExceptionWrapper.toString());
  }

  @override
  void onUncaugth(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    logE(appExceptionWrapper.toString());
  }

  @override
  void onFirebaseAuthException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    // navigator.showErrorSnackBar(appExceptionWrapper.appError.message);
    logE(appExceptionWrapper.toString());
  }

  @override
  void onFirebaseFunctionsException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    // navigator.showErrorSnackBar(appExceptionWrapper.appError.message);
    logE(appExceptionWrapper.toString());
  }
}
