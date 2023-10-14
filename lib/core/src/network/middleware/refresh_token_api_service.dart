import 'package:bedtime_stories/core/core.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RestNonAuthClient _refreshTokenApiClient;

  Future<DataResponse<RefreshTokenData>> refreshToken(
    String refreshToken,
  ) async {
    try {
      final respone = await _refreshTokenApiClient.refreshToken();
      return respone;
    } catch (e) {
      throw RefreshTokenException;
    }
  }
}
