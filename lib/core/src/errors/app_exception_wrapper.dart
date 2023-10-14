import 'package:bedtime_stories/core/core.dart';

class AppExceptionWrapper {
  AppExceptionWrapper({
    required this.appError,
    this.doOnRetry,
  });

  final AppError appError;

  final Future<void> Function()? doOnRetry;

  @override
  String toString() => appError.toString();
}
