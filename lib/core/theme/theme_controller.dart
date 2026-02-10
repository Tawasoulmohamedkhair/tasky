import 'package:flutter/material.dart';
import 'package:tasky/core/constant/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> notifierthem = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    final bool result = PreferencesManager().getBool(StorageKey.theme) ?? true;

    notifierthem.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  toggleTheme() {
    notifierthem.value = notifierthem.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    PreferencesManager().setBool(
      StorageKey.theme, notifierthem.value == ThemeMode.dark);
  }
  static bool isDark()=>notifierthem.value==ThemeMode.dark;
}
