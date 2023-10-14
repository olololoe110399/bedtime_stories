import 'package:bedtime_stories/core/core.dart';
import 'package:dio/dio.dart';

class ErrorMapperFactory {
  static AppError map(Object error) {
    switch (error.runtimeType) {
      case DioException:
        print(error);
        print((error as DioException).response);
        final message =
            (error as DioException).response?.data['error']['message'];
        return AppError(
          appExceptionType: AppExceptionType.dioError,
          message: message ?? (error).response?.statusMessage,
          error: error,
        );
      case NotInterNetException:
        return AppError(
          appExceptionType: AppExceptionType.noInternet,
          message: 'No Internet Connection',
          error: error,
        );
      case ServerException:
        return AppError(
          appExceptionType: AppExceptionType.serverError,
          message: error.toString(),
          error: error,
        );
      case RefreshTokenException:
        return AppError(
          appExceptionType: AppExceptionType.refreshTokenFail,
          message: error.toString(),
          error: error,
        );
      case CacheException:
        return AppError(
          appExceptionType: AppExceptionType.cacheError,
          message: error.toString(),
          error: error,
        );
      case ValidateEmptyException:
        return AppError(
          appExceptionType: AppExceptionType.validateEmpty,
          message: 'Value not Empty',
          error: error,
        );
      case ValidateWrongEmailException:
        return AppError(
          appExceptionType: AppExceptionType.validateWrongEmail,
          message: 'Wrong email format',
          error: error,
        );
      case ValidateWrongPasswordException:
        return AppError(
          appExceptionType: AppExceptionType.validateWrongPassword,
          message: 'Password must be at least 6 characters',
          error: error,
        );
      default:
        return AppError(
          appExceptionType: AppExceptionType.uncaugth,
          message: error.toString(),
          error: error,
        );
    }
  }
}
