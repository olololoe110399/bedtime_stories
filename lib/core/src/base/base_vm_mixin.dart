import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:bedtime_stories/core/core.dart';
// import 'package:rxdart/rxdart.dart';

mixin BaseVMMixin<E extends BaseEvent, S extends BaseState>
    on BaseVMDelegete<E, S> {
  Future<void> runCatching<T>(
    FutureOr<Either<AppError, T>> action, {
    FutureOr<void> Function(AppError)? doOnError,
    FutureOr<void> Function(T)? doOnSuccess,
    Future<void> Function()? doOnRetry,
    FutureOr<void> Function()? doOnCompleleted,
    bool isHandleLoading = true,
    bool isHandleError = true,
  }) async {
    if (isHandleLoading) {
      showLoading();
    }
    final value = await action;
    await value.fold(
      (appError) async {
        if (isHandleLoading) {
          hideLoading();
        }
        if (isHandleError) {
          addException(
            AppExceptionWrapper(
              appError: appError,
              doOnRetry: doOnRetry,
            ),
          );
        }
        await doOnError?.call(appError);
      },
      (r) async {
        if (isHandleLoading) {
          hideLoading();
        }
        await doOnSuccess?.call(r);
      },
    );
    await doOnCompleleted?.call();
  }
}
