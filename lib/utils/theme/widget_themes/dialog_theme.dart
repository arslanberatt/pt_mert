import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class CustomDialogTheme {
  static final light = DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusImageCard),
    ),
    titleTextStyle: const TextStyle(
      color: AppColors.blackTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: const TextStyle(
      color: AppColors.hintTextColor,
      fontSize: 14,
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
}
