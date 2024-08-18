import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.purple,
    dividerColor: Colors.white,
    highlightColor: Colors.grey.shade400,
    canvasColor: Colors.grey.shade300,
    secondaryHeaderColor: Colors.grey.shade300,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.withOpacity(0.4)),
    cardColor: Colors.white,
    hoverColor: Colors.purple,
    searchViewTheme: SearchViewThemeData(backgroundColor: Colors.grey.shade300),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.vazirmatn(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: Colors.black
      ),
      titleMedium: GoogleFonts.vazirmatn(
        color: Colors.grey,
        fontSize: 15,
        fontWeight: FontWeight.w300
      ),
      titleSmall: GoogleFonts.vazirmatn(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400
      ),
      labelMedium: GoogleFonts.vazirmatn(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w300
      ),
        titleLarge: GoogleFonts.vazirmatn(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700
        )
    ),
        scaffoldBackgroundColor: Colors.white,
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blueAccent,
    dividerColor: Colors.blueAccent,
    canvasColor: Colors.blueAccent,
    secondaryHeaderColor: Colors.white,
    primaryColorLight: Colors.blueAccent,
    highlightColor: Colors.blueAccent.shade700,
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.blueAccent),
    hoverColor: Colors.blueAccent,
    searchViewTheme: const SearchViewThemeData(backgroundColor: Colors.blueAccent, ),
    cardColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white,),
    textTheme: TextTheme(
      labelMedium: GoogleFonts.vazirmatn(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w300
      ),
      bodyMedium: GoogleFonts.vazirmatn(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: Colors.black
      ),

      titleMedium: GoogleFonts.vazirmatn(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300
      ),
      titleSmall: GoogleFonts.vazirmatn(
        color: Colors.grey.shade300,
        fontSize: 12,
        fontWeight: FontWeight.w400
      ),
      titleLarge: GoogleFonts.vazirmatn(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w800
      )
    ),
        scaffoldBackgroundColor: Colors.black,
  );
}