import 'package:flutter/material.dart';

class AppColors {
  // Background & Surface
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF5F6F6);
  static const Color inputFieldColor = Color(0xFFBBBBBB); // eski gray4Color

  // Text & Icon Colors
  static const Color primaryTextColor = Color(0xFF282726); // eski grayColor
  static const Color secondaryTextColor = Color(0xFF54504C); // eski gray2Color
  static const Color hintTextColor = Color(0xFFAAAAAA); // eski gray3Color
  static const Color borderColor = Color(0xFFBBBBBB); // eski gray4Color
  static const Color blackTextColor = Color(0xFF151522);
  static const Color hardGrayTextColor = Color.fromARGB(255, 81, 80, 80);

  // Primary / Accent
  static const Color primaryColor = Color(0xFFD73B3E); // kırmızı ton
  static const Color todayColor = Color(0xFFB2BDC3CB); // kırmızı ton
  static const Color selectedDayColor = Color.fromARGB(
    255,
    36,
    36,
    37,
  ); // kırmızı ton

  // Gradients
  static const Gradient darkGradient = LinearGradient(
    colors: <Color>[blackTextColor, secondaryTextColor],
  );

  static const Gradient verticalDarkGradient = LinearGradient(
    colors: <Color>[blackTextColor, secondaryTextColor],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient backgroundGradient = LinearGradient(
    colors: <Color>[backgroundColor, surfaceColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient accentGradient = LinearGradient(
    colors: <Color>[blackTextColor, hintTextColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
