import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IDatabaseManager {
  Future<void> start();
  Future<void> clear();
}

@immutable
final class HiveDatabaseManager implements IDatabaseManager {
  final String _subDirectory = 'vb10';
  @override
  Future<void> start() async {
    await _open();
    initialOperation();
  }

  @override
  Future<void> clear() async {
    await Hive.deleteFromDisk();
    await FileOperation.instance.removeSubDirectory(_subDirectory);
  }

  /// Open your database connection
  /// Now using [Hive]
  Future<void> _open() async {
    final subPath =
        await FileOperation.instance.createSubDirectory(_subDirectory);
    await Hive.initFlutter(subPath);
  }

  /// Register your generic model or make your operation before start
  void initialOperation() {
    Hive.registerAdapter(StoryHiveModelAdapter());
  }
}
