import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class CustomColors {
  static const Color gray = Color.fromRGBO(137, 150, 184, 1);
  static const Color mainText = Color.fromRGBO(9, 17, 39, 1);
  static const Color green = Color.fromRGBO(7, 95, 227, 1);
  static const Color background = Color.fromRGBO(247, 250, 255, 1);

  // dark mode
  // static const Color background = Color.fromRGBO(9, 18, 39, 1);
  // static const Color gray = Color.fromRGBO(120, 120, 120, 1);
  // static const Color mainText = Color.fromRGBO(234, 240, 255, 1);
  // static const Color green = Color.fromRGBO(7, 95, 227, 1);

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;

  static Future<Color> generatePaletteColor(url) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      AssetImage(url),
    );
    return paletteGenerator.paletteColors[0].color;
  }

  static Widget glowEffect(glowColor) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: glowColor,
                blurRadius: 30,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
        ));
  }
}
