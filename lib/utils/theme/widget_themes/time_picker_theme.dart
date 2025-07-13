import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class CustomTimePickerTheme {
  static final light = TimePickerThemeData(
    backgroundColor: Colors.white,
    dialBackgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingContainerM),
    ),
    padding: const EdgeInsets.all(16),

    // Butonlar
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
    ),

    // Saat & Dakika kutuları
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
    ),
    hourMinuteColor: AppColors.primaryColor.withOpacity(0.12),
    hourMinuteTextColor: AppColors.primaryColor,
    hourMinuteTextStyle: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),

    // AM/PM kutuları
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
    ),
    dayPeriodBorderSide: BorderSide(color: AppColors.primaryColor),
    dayPeriodColor: AppColors.primaryColor.withOpacity(0.12),
    dayPeriodTextColor: AppColors.primaryColor,
    dayPeriodTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.hintTextColor,
    ),

    // Çark görünümü
    dialHandColor: AppColors.hintTextColor,
    dialTextColor: AppColors.primaryTextColor,
    dialTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.primaryTextColor,
    ),

    // Giriş modu ikonu ve yardım yazısı
    entryModeIconColor: AppColors.primaryColor,
    helpTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.hintTextColor,
    ),

    // Input kutuları
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
      ),
    ),

    // Saat & dakika ayırıcı
    timeSelectorSeparatorColor: MaterialStateProperty.all(
      AppColors.primaryColor,
    ),
    timeSelectorSeparatorTextStyle: MaterialStateProperty.all(
      const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
