import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewUtils {
  const ViewUtils._();
  static const _defaultSnackBarDuration = Duration(seconds: 2);

  static void showAppSnackBar(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
  }) {
    final messengerState = ScaffoldMessenger.maybeOf(context);
    if (messengerState == null) {
      return;
    }
    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        duration: duration ?? _defaultSnackBarDuration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }

  /// set status bar color & navigation bar color
  static void setSystemUIOverlayStyle(
      SystemUiOverlayStyle systemUiOverlayStyle) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static bool hasTextOverflow(
    String text,
    TextStyle style, {
    double maxWidth = double.infinity,
    int maxLines = 2,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }
}
