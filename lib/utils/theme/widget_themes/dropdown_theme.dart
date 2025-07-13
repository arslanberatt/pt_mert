import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomDropdownTheme {
  static final light = DropdownMenuThemeData(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.blackTextColor,
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.backgroundColor),
      elevation: WidgetStatePropertyAll(2),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
