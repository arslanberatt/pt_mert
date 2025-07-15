import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomElevatedButtonTheme {
  static final light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.blackTextColor, // Siyah gibi görünüm
      foregroundColor: Colors.white, // Yazı rengi beyaz
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Görsele yakın oval
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700, // Bold
        fontSize: 15,
        letterSpacing: 0.5,
      ),
    ),
  );
}
