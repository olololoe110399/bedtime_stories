import 'package:dartz/dartz.dart';

class AppError {
  AppError({
    required this.appExceptionType,
    required this.message,
    required this.error,
  });
  final String message;
  final Object error;
  final AppExceptionType appExceptionType;

  @override
  int get hashCode => Object.hash(appExceptionType, message, error);

  @override
  String toString() =>
      'AppError{appExceptionType: $appExceptionType, message: $message, error: $error}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppError &&
          runtimeType == other.runtimeType &&
          appExceptionType == other.appExceptionType &&
          message == other.message &&
          error == other.error;
}

enum AppExceptionType {
  dioError,
  uncaugth,
  noInternet,
  serverError,
  cacheError,
  refreshTokenFail,
  validateEmpty,
  validateWrongEmail,
  validateWrongPassword,
}

typedef Result<T> = Either<AppError, T>;
typedef UnitResult = Result<Unit>;
