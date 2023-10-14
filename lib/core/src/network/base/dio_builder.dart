import 'package:bedtime_stories/core/core.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout:
            options?.connectTimeout ?? NetworkConstants.connectTimeout,
        receiveTimeout:
            options?.receiveTimeout ?? NetworkConstants.receiveTimeout,
        sendTimeout: options?.sendTimeout ?? NetworkConstants.sendTimeout,
        baseUrl: options?.baseUrl ?? NetworkConstants.appApiBaseUrl,
        contentType: options?.contentType ?? Headers.jsonContentType,
      ),
    );

    final sortedInterceptors = [
      CustomLogInterceptor(),
      ...interceptors,
    ].sortedByDescending((element) {
      return element is BaseInterceptor ? element.priority : -1;
    });

    dio.interceptors.addAll(sortedInterceptors);

    return dio;
  }
}
