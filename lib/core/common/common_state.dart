import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_state.freezed.dart';

@freezed
class CommonState extends BaseState with _$CommonState {
  const factory CommonState({
    @Default(LocaleConstants.defaultLocale) String locale,
    @Default(ThemeMode.light) ThemeMode themeMode,
  }) = _CommonState;
}
