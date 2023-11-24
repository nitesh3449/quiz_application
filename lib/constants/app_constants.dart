import 'package:flutter/material.dart';

class AppConstants {
  static  BoxDecoration unSelectedDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey, width: 1.0),
  );

  static  BoxDecoration selectedDecoration = BoxDecoration(
    color: Colors.green.shade200.withOpacity(0.1),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.green.shade700, width: 1.5),
  );

  static  BoxDecoration incorrectDecoration = BoxDecoration(
    color: Colors.red.shade200.withOpacity(0.1),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.red, width: 1.5),
  );
}

// 7903801372

class AppColor {
  static const Color primaryColor = Colors.amberAccent;
  static const Color secondaryColor = Colors.amberAccent;
  static Color backgroundColor = Colors.white.withOpacity(0.95);
  static const Color fontColor = Colors.black;
  static const Color greenColor = Colors.green;
  static const Color whiteColor = Colors.white;
  static const Color redColor = Colors.red;
  static Color selectedColor = Colors.green.shade700;
  static Color unSelectedColor = Colors.grey;
  static const Color greyColor = Colors.grey;
  static Color dividerColor = Colors.grey.shade400;
}

class TextSize {
  static const double fontSize = 16;
  static const double headerSize = 20;
  static const double xSmallFont = 12;
  static const double smallFont = 14;
  static const double normalFont = 16;
  static const double mediumFont = 18;
  static const double largeFont = 20;
  static const double buttonFont = 18;
  static const double questionFontSize = 16;
  static const double optionFontSize = 16;
  static const double optionHeaderFontSize = 16;
}
