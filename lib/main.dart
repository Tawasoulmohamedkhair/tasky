import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/myapp/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  ThemeController().init();

  String? username = PreferencesManager().getString('username');

  runApp(MyApp(username: username));
}
