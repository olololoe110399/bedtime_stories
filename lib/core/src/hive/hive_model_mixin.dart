part of 'hive_operation.dart';

abstract class HiveManagerInitialModel {
  HiveEncryption get _encryption;
}

mixin HiveManagerMixin<T> on HiveManagerInitialModel {
  final String _key = T.toString();

  late Box<T> _box;

  Future<void> start() async {
    if (Hive.isBoxOpen(_key)) return;
    final encryptionKey = await _encryption.getSecureKey();
    _box = await Hive.openBox<T>(
      _key,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  Future<void> clear() => _box.clear();
}
