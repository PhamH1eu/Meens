import 'package:flutter/material.dart';

class CustomColors {
  ThemeData lightTheme = ThemeData(
    fontFamily: 'Gilroy',
    primaryColor: const Color.fromRGBO(9, 17, 39, 1),
    secondaryHeaderColor: const Color.fromRGBO(137, 150, 184, 1),
    focusColor: const Color.fromARGB(255, 240, 242, 246),
    hintColor: const Color.fromRGBO(9, 18, 39, 0.15),
    scaffoldBackgroundColor: const Color.fromRGBO(247, 250, 255, 1),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(247, 250, 255, 1),
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 17, 39, 1))),
  );

  ThemeData darkTheme = ThemeData(
    fontFamily: 'Gilroy',
    primaryColor: const Color.fromRGBO(234, 240, 255, 1),
    secondaryHeaderColor: const Color.fromRGBO(165, 192, 255, 0.7),
    focusColor: const Color.fromARGB(255, 11, 25, 49),
    hintColor: const Color.fromRGBO(255, 255, 255, 0.31),
    scaffoldBackgroundColor: const Color.fromRGBO(9, 18, 39, 1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(9, 18, 39, 1),
      iconTheme: IconThemeData(color: Color.fromRGBO(234, 240, 255, 1)),
    ),
  );

  //font
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;

}
