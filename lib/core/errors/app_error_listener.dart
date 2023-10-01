import 'package:bedtime_stories/core/errors/errors.dart';
import 'package:flutter/material.dart';

abstract class AppErrorListener {
  void onNoInternet(
      AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onUncaugth(
      AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onFirebaseAuthException(
      AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onFirebaseFunctionsException(
      AppExceptionWrapper appExceptionWrapper, BuildContext context);
}
