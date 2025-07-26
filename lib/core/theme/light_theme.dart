import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
  ),
  colorScheme: ColorScheme.light(primaryContainer: Color(0xffFFFFFF)),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xff15B86C)),
      foregroundColor: WidgetStatePropertyAll(Color(0xffFFFCFC)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      minimumSize: WidgetStatePropertyAll(Size(340, 40)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Color(0xff161F1B)),

      // elevation: WidgetStatePropertyAll(12),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      minimumSize: WidgetStatePropertyAll(Size(40, 40)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffFFFFFF),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xff3A4640),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xff3A4640),
    ),

    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      overflow: TextOverflow.ellipsis,
      decorationColor: Color(0xff49454F),
      color: Color(0xff6A6A6A),
    ),

    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
      fontSize: 20,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    bodySmall: TextStyle(color: Colors.black, fontSize: 24),

    labelLarge: TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? Color(0xffFFFCFC)
              : Color(0xff9E9E9E),
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? Color(0xff15B86C)
              : Color(0xffFFFCFC),
    ),
    trackOutlineColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? Colors.transparent
              : Color(0xff9E9E9E),
    ),
    trackOutlineWidth: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected) ? 0 : 2,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xffFFFFFF),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),

      borderRadius: BorderRadius.circular(16),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(width: 2, color: Color(0xffD1DAD6)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xff3A4640)),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(color: Color(0xff161F1B)),
    contentTextStyle: TextStyle(color: Color(0xff161F1B)),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    shadowColor: Color(0xff15B86C),

    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xff161F1B),
      ),
    ),
  ),
);
