import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bedtime_stories/core/core.dart';

part 'common_event.freezed.dart';

@freezed
class CommonEvent extends BaseEvent with _$CommonEvent {
  const factory CommonEvent.appThemeChanged(ThemeMode themeMode) =
      AppThemeChanged;
  // const factory CommonEvent.appLanguageChanged(LanguageCode languageCode) =
  //     AppLanguageChanged;
}
