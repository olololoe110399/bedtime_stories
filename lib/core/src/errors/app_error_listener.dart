import 'package:bedtime_stories/core/core.dart';

abstract class AppErrorListener {
  void onNoInternet(AppExceptionWrapper appExceptionWrapper);
  void onUncaugth(AppExceptionWrapper appExceptionWrapper);
  void onServerError(AppExceptionWrapper appExceptionWrapper);
  void onRefreshTokenFail(AppExceptionWrapper appExceptionWrapper);
}
