import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';

class AppHandleException {
  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
    AppErrorListener errorListener,
  ) async {
    switch (appExceptionWrapper.appError.appExceptionType) {
      case AppExceptionType.noInternet:
        return errorListener.onNoInternet(appExceptionWrapper);
      case AppExceptionType.uncaugth:
        return errorListener.onUncaugth(appExceptionWrapper);
      case AppExceptionType.dioError:
        return errorListener.onServerError(appExceptionWrapper);
      case AppExceptionType.refreshTokenFail:
        return errorListener.onRefreshTokenFail(appExceptionWrapper);
      default:
        return errorListener.onUncaugth(appExceptionWrapper);
    }
  }
}
