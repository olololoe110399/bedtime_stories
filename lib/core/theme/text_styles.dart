import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static String fontFamily = 'Poppins';

  /// Text style for body
  static TextStyle bodyLg = const TextStyle(
    fontSize: Dimens.d16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body = const TextStyle(
    fontSize: Dimens.d14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySm = const TextStyle(
    fontSize: Dimens.d12,
    fontWeight: FontWeight.w300,
  );

  static TextStyle bodyXs = const TextStyle(
    fontSize: Dimens.d10,
    fontWeight: FontWeight.w300,
  );

  /// Text style for heading

  static TextStyle h1 = const TextStyle(
    fontSize: Dimens.d24,
    fontWeight: FontWeight.w700,
  );

  static TextStyle h2 = const TextStyle(
    fontSize: Dimens.d22,
    fontWeight: FontWeight.w700,
  );

  static TextStyle h3 = const TextStyle(
    fontSize: Dimens.d20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle h4 = const TextStyle(
    fontSize: Dimens.d18,
    fontWeight: FontWeight.w500,
  );
}
