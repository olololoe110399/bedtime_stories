import 'package:async/async.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/di/di.dart';
import 'package:dart_openai/dart_openai.dart';

class AppConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  final AsyncMemoizer<void> _asyncMemoizer = AsyncMemoizer<void>();

  Future<void> init() => _asyncMemoizer.runOnce(config);

  Future<void> config() async {
    await HiveDatabaseManager().start();
    OpenAI.apiKey = Env.apiKey;
    OpenAI.requestsTimeOut = const Duration(seconds: 60);
    OpenAI.showLogs = LogConstants.enableLog;
    OpenAI.showResponsesLogs = LogConstants.enableLog;
    // await Firebase.initializeApp();
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await configureInjection();
  }
}
