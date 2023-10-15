import 'package:async/async.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/di/di.dart';

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
    // await Firebase.initializeApp();
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await configureInjection();
  }
}
