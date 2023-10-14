import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_non_auth_client.g.dart';

@RestApi()
abstract class RestNonAuthClient {
  factory RestNonAuthClient(Dio dio, {String baseUrl}) = _RestNonAuthClient;

  @POST('/v1/auth/refresh')
  Future<DataResponse<RefreshTokenData>> refreshToken();

  @POST('/v1/chat/completions')
  Future<ChatCompletionModel> completions(
    @Header('Authorization') String apiToken,
    @Body() ChatRequestModel body,
  );
}
