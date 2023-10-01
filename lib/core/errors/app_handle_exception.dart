import 'package:bedtime_stories/core/errors/errors.dart';
import 'package:flutter/material.dart';

class AppHandleException {
  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
    AppErrorListener errorListener,
  ) async {
    switch (appExceptionWrapper.appError.appExceptionType) {
      case AppExceptionType.noInternet:
        return errorListener.onNoInternet(appExceptionWrapper, context);
      case AppExceptionType.uncaugth:
        return errorListener.onUncaugth(appExceptionWrapper, context);
      case AppExceptionType.firebaseAuth:
        return errorListener.onFirebaseAuthException(
            appExceptionWrapper, context);
      case AppExceptionType.firebaseFunctions:
        return errorListener.onFirebaseFunctionsException(
            appExceptionWrapper, context);
      default:
        return errorListener.onUncaugth(appExceptionWrapper, context);
    }
  }
}
