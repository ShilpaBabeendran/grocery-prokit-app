import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    // fontFamily: "Poppins",
    useMaterial3: true,
    colorSchemeSeed:const Color(0xFF00C569) ,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF00C569)
    ),
  );
}
