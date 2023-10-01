import 'package:bedtime_stories/core/errors/errors.dart';

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
