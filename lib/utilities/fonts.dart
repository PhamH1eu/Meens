import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tinycolor2/tinycolor2.dart';

class CustomColors {
  ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromRGBO(9, 17, 39, 1),
    secondaryHeaderColor: const Color.fromRGBO(137, 150, 184, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(247, 250, 255, 1),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(247, 250, 255, 1),
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 17, 39, 1))),
  );

  ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color.fromRGBO(234, 240, 255, 1),
    secondaryHeaderColor: const Color.fromRGBO(165, 192, 255, 0.7),
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

  //get dominant color
  static Future<Color> generatePaletteColor(url) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      AssetImage(url),
    );
    print(paletteGenerator.paletteColors[0].color);
    return paletteGenerator.paletteColors[0].color;
  }

  //glow effect under image
  static Widget glowEffect(glowColor) {
    final TinyColor glow = TinyColor.fromColor(glowColor).lighten(20);

    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: glow.color,
                blurRadius: 30,
                spreadRadius: 10,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
        ));
  }
}
