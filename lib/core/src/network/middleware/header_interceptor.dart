import 'package:bedtime_stories/core/core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HeaderInterceptor extends BaseInterceptor {
  @override
  int get priority => BaseInterceptor.accessTokenPriority;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.contentType == null) {
      final dynamic data = options.data;
      final String? contentType;
      if (data is FormData) {
        contentType = Headers.multipartFormDataContentType;
      } else if (data is Map) {
        contentType = Headers.formUrlEncodedContentType;
      } else if (data is String) {
        contentType = Headers.jsonContentType;
      } else if (data != null) {
        contentType = Headers.jsonContentType;
      } else {
        contentType = null;
      }
      options.contentType = contentType;
    }
    handler.next(options);
  }
}
