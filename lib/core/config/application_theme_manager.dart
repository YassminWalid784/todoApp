import 'package:flutter/material.dart';

class ApplicationThemeManager {
  static  Color primaryColor = const Color(0xFF5D9CEC);
  static ThemeData lightThemeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFFDFECDB),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Colors.white,
              width: 5,
            ))),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.zero,
      color: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 36,
      ),
      unselectedIconTheme:
      const IconThemeData(color: Color(0xFFC8C9CB), size: 30),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color:  Color(0xFF5D9CEC),
      ),
      bodySmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darkThemeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF060E1E),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Color(0xFF060E1E),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF060E1E),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Color(0xFF707070),
              width: 5,
            ))),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.zero,
      color: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 36,
      ),
      unselectedIconTheme:
      const IconThemeData(color: Color(0xFFC8C9CB), size: 30),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
