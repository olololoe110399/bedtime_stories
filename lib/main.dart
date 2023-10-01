import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runZonedGuarded(
      _runMyApp,
      (error, stackTrace) => _reportError(
        error: error,
        stackTrace: stackTrace,
      ),
    );

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.getInstance().init();
  runApp(
    ProviderScope(
      observers: [
        AppProviderObservers(),
      ],
      child: const MyApp(),
    ),
  );
}

void _reportError({required error, required StackTrace stackTrace}) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');
  // FirebaseCrashlytics.instance.recordError(error, stackTrace);
}
