import 'package:credstream/core/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: kBlue,
      ),
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(fontFamily: 'Unbounded', fontSize: 19, color: kBlack),
        bodyLarge: TextStyle(
            color: kBlack,
            fontFamily: 'ShantellSans',
            fontSize: 16,
            fontWeight: FontWeight.w700),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kWhite,
          selectedItemColor: kBlue,
          unselectedItemColor: kBlack));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(
          color: kBlack,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(fontFamily: 'Unbounded', fontSize: 19, color: kWhite),
        bodyLarge: TextStyle(
            color: kWhite,
            fontFamily: 'ShantellSans',
            fontSize: 16,
            fontWeight: FontWeight.w700),
      ),
      cardTheme: const CardTheme(
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: kBlue,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kBlack,
          selectedItemColor: kBlue,
          unselectedItemColor: kGrey400));
}
