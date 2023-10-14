import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bedtime_stories/core/core.dart';

import 'di.config.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );

  @singleton
  RestClient restClient(
    AccessTokenInterceptor accessTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
    HeaderInterceptor headerInterceptor,
  ) =>
      RestClient(
        DioBuilder.createDio(
          interceptors: [
            accessTokenInterceptor,
            refreshTokenInterceptor,
            headerInterceptor,
          ],
        ),
      );

  @singleton
  RestNonAuthClient refreshRestClient(
    AccessTokenInterceptor accessTokenInterceptor,
    HeaderInterceptor headerInterceptor,
  ) =>
      RestNonAuthClient(
        DioBuilder.createDio(
          interceptors: [
            accessTokenInterceptor,
            headerInterceptor,
          ],
        ),
      );

  @injectable
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance();
}

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() => getIt.init();
