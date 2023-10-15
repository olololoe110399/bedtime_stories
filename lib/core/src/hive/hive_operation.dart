import 'package:bedtime_stories/core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model_mixin.dart';

class HiveDatabaseOperation<T extends HiveModelMixin>
    extends HiveManagerInitialModel with HiveManagerMixin<T> {
  HiveDatabaseOperation({
    required PrimitiveDatabase primitiveDatabase,
  }) {
    _encryption = HiveEncryption(
      primitiveDatabase: primitiveDatabase,
    );
  }

  Stream<List<T>> streamItems() {
    return Stream.value(_box.listenable())
        .map((event) => event.value.values.toList());
  }

  @override
  late final HiveEncryption _encryption;

  Future<void> addOrUpdateItem(T model) => _box.put(model.key, model);

  T? getItem(String key) => _box.get(key);

  Future<void> deleteItem(String key) => _box.delete(key);
}
