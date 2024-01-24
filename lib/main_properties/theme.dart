import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'ProductSans',
  scaffoldBackgroundColor: Colors.white.withOpacity(0.97),
  appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 8, backgroundColor: Colors.white),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.pink[50],
    unselectedLabelStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 0, 157),
    ),
  ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(background: Colors.white.withOpacity(0.97)).copyWith(error: const Color.fromARGB(255, 255, 0, 157)),
);
