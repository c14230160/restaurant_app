import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: GoogleFonts.poppins().fontFamily,

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
