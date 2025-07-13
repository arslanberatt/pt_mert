import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomElevatedButtonTheme {
  static final light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.primaryTextColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50), // Tam oval görünüm
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 0.3,
      ),
    ),
  );
}
