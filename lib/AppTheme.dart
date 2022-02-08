import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/utils/colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: appStore.primaryColors,
    errorColor: Colors.red,
    hoverColor: Colors.grey,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: appStore.primaryColors,
     // brightness: appStore.primaryColors.isDark() ? Brightness.dark : Brightness.light,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    cardTheme: CardTheme(color: Colors.white),
    textTheme: TextTheme(
      subtitle1: TextStyle(color: textColorSecondary),
      subtitle2: TextStyle(color: textColorPrimary),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF131d25),
    errorColor: Color(0xFFCF6676),
    appBarTheme: AppBarTheme(
      color: appStore.primaryColors,
      //brightness: appStore.primaryColors.isDark() ? Brightness.dark : Brightness.light,
    ),
    primaryColor: appStore.primaryColors,
    fontFamily: GoogleFonts.poppins().fontFamily,
    cardTheme: CardTheme(color: Color(0xFF1D2939)),
    iconTheme: IconThemeData(color: Colors.white70),
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white70),
      subtitle2: TextStyle(color: Colors.white30),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
