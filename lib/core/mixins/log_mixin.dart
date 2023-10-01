import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

mixin LogMixin on Object {
  void logD(
    Object? message, {
    String? name,
    DateTime? time,
  }) {
    _log('$message', name: name ?? '', time: time);
  }

  void logE(
    Object? message, {
    String? name,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      '$message',
      name: name ?? '',
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  String prettyJson(Map<String, dynamic> json) {
    final indent = '  ' * 2;

    final encoder = JsonEncoder.withIndent(indent);

    return encoder.convert(json);
  }

  void _log(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    String name = '',
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    dev.log(
      message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
