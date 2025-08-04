import 'package:flutter/material.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/screens/main_screen.dart';
import 'package:tasky/features/screens/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.notifierthem,
      builder:
          (context, ThemeMode thememode, Widget? child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: thememode,
            home: username == null ? WelcomScreen() : MainScreen(),
          ),
    );
  }
}
