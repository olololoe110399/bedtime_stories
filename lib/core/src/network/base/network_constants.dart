class NetworkConstants {
  const NetworkConstants._();
  static const connectTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);
  static const sendTimeout = Duration(seconds: 30);

  static const basicAuthorization = 'Authorization';
  static const bearer = 'Bearer';

  static String get appApiBaseUrl => 'https://api.openai.com';
}
