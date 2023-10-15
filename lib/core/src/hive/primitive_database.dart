import 'package:bedtime_stories/core/core.dart';

abstract class PrimitiveDatabase {
  Future<T?> read<T>(PrimitiveKeys key);

  Future<bool> write<T>({required PrimitiveKeys key, required T data});
}
