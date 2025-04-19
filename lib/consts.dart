import 'package:calorie/getx/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double height = Get.height;

double width = Get.width;
final SettingsController settingsControllerConst = Get.find();
String slash() {
  return settingsControllerConst.lang == 'ar' ? '\\' : '/';
}

SizedBox h(double h) {
  return SizedBox(
    height: h,
  );
}

SizedBox w(double w) {
  return SizedBox(
    width: w,
  );
}

List<Color> colors = [
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.red,
  const Color.fromARGB(255, 95, 1, 1)
];

TextTheme lightTextTheme(String font) {
  return TextTheme(
    bodyLarge: TextStyle(
      fontFamily: font,
    ),
    bodyMedium: TextStyle(fontFamily: font, color: Colors.black),
    displayLarge: TextStyle(fontFamily: font),
    displayMedium: TextStyle(fontFamily: font),
    displaySmall: TextStyle(fontFamily: font),
    headlineMedium: TextStyle(fontFamily: font),
    headlineLarge: TextStyle(fontFamily: font),
    headlineSmall: TextStyle(fontFamily: font),
    titleLarge: TextStyle(fontFamily: font),
    titleMedium: TextStyle(fontFamily: font),
    titleSmall: TextStyle(fontFamily: font),
    bodySmall: TextStyle(fontFamily: font),
    labelLarge: TextStyle(fontFamily: font),
    labelSmall: TextStyle(fontFamily: font),
    labelMedium: TextStyle(fontFamily: font),
  );
}

TextTheme darkTextTheme(String font) {
  return TextTheme(
    bodyLarge: TextStyle(fontFamily: font, color: Colors.black),
    bodyMedium: TextStyle(fontFamily: font),
    displayLarge: TextStyle(fontFamily: font),
    displayMedium: TextStyle(fontFamily: font),
    displaySmall: TextStyle(fontFamily: font),
    headlineMedium: TextStyle(fontFamily: font),
    headlineSmall: TextStyle(fontFamily: font),
    headlineLarge: TextStyle(fontFamily: font),
    labelMedium: TextStyle(fontFamily: font),
    titleLarge: TextStyle(fontFamily: font),
    titleMedium: TextStyle(fontFamily: font),
    titleSmall: TextStyle(fontFamily: font),
    bodySmall: TextStyle(fontFamily: font),
    labelLarge: TextStyle(fontFamily: font),
    labelSmall: TextStyle(fontFamily: font),
  );
}
