import 'package:bedtime_stories/core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomLogInterceptor extends BaseInterceptor {
  static const enableLogInterceptor = kDebugMode;
  static const enableLogRequestInfo = kDebugMode;
  static const enableLogSuccessResponse = false;
  static const enableLogErrorResponse = kDebugMode;

  @override
  int get priority => BaseInterceptor.customLogPriority;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!enableLogInterceptor || !enableLogRequestInfo) {
      handler.next(options);

      return;
    }

    final log = <String>[];
    log.add('************ Request ************');
    log.add('🌐 Request: ${options.method} ${options.uri}');
    if (options.headers.isNotEmpty) {
      log.add('🌐 Request Headers:');
      log.add('🌐 ${_prettyResponse(options.headers)}');
    }

    if (options.data != null) {
      log.add('🌐 Request Body:');
      if (options.data is FormData) {
        final data = options.data as FormData;
        if (data.fields.isNotEmpty) {
          log.add('🌐 Fields: ${_prettyResponse(data.fields)}');
        }
        if (data.files.isNotEmpty) {
          log.add(
            '🌐 Files: ${_prettyResponse(data.files.map((e) => MapEntry(e.key, 'File name: ${e.value.filename}, Content type: ${e.value.contentType}, Length: ${e.value.length}')))}',
          );
        }
      } else {
        log.add('🌐 ${_prettyResponse(options.data)}');
      }
    }

    Log.d(log.join('\n'));
    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (!enableLogInterceptor || !enableLogSuccessResponse) {
      handler.next(response);

      return;
    }

    final log = <String>[];

    log.add('************ Request Response ************');
    log.add(
      '🎉 ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    log.add(
        '🎉 Request Body: ${_prettyResponse(response.requestOptions.data)}');
    log.add('🎉 Success Code: ${response.statusCode}');
    log.add('🎉 ${_prettyResponse(response.data)}');

    Log.d(log.join('\n'));
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!enableLogInterceptor || !enableLogErrorResponse) {
      handler.next(err);

      return;
    }

    final log = <String>[];

    log.add('************ Request Error ************');
    log.add('⛔️ ${err.requestOptions.method} ${err.requestOptions.uri}');
    log.add(
        '⛔️ Error Code: ${err.response?.statusCode ?? 'unknown status code'}');
    log.add('⛔️ Json: ${err.response}');

    Log.e(log.join('\n'));
    handler.next(err);
  }

  // ignore: avoid-dynamic
  String _prettyResponse(dynamic data) {
    if (data is Map) {
      return Log.prettyJson(data as Map<String, dynamic>);
    }

    return data.toString();
  }
}
