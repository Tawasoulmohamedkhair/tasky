import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: Color(0xff181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    foregroundColor: Color(0xffFFFCFC),
    centerTitle: false,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
  ),
  colorScheme: ColorScheme.light(primaryContainer: Color(0xff282828)),

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
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff282828)),
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
      foregroundColor: WidgetStatePropertyAll(Color(0xffFFFCFC)),

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
    backgroundColor: Color(0xff181818),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xffC6C6C6),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xffC6C6C6),
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      overflow: TextOverflow.ellipsis,
      decorationColor: Color(0xff49454F),
      color: Color(0xffA0A0A0),
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
      fontSize: 20,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    labelLarge: TextStyle(color: Color(0xffFFFCFC), fontSize: 14),
    bodySmall: TextStyle(color: Colors.white, fontSize: 24),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff282828),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    hintStyle: TextStyle(color: Color(0xff6D6D6D)),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(width: 2, color: Color(0xff6E6E6E)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  iconTheme: IconThemeData(color: Color(0xffC6C6C6)),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(color: Colors.white),
    contentTextStyle: TextStyle(color: Colors.white),
  ),
  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(width: 1, color: Color(0xff15B86C)),
    ),
    elevation: 2,
    shadowColor: Color(0xff15B86C),

    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    ),
  ),
);
