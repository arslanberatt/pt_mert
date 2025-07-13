import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class CustomDatePickerTheme {
  static final light = DatePickerThemeData(
    backgroundColor: AppColors.backgroundColor,
    elevation: 4,
    shadowColor: Colors.black26,
    surfaceTintColor: AppColors.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingContainerM),
    ),

    // Header
    headerBackgroundColor: AppColors.primaryColor,
    headerForegroundColor: Colors.white,
    headerHeadlineStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headerHelpStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    // Weekdays & Days
    weekdayStyle: const TextStyle(color: AppColors.primaryColor),
    dayStyle: const TextStyle(color: AppColors.primaryTextColor),
    dayForegroundColor: WidgetStateProperty.all(AppColors.primaryTextColor),
    dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    dayOverlayColor: WidgetStateProperty.all(
      // ignore: deprecated_member_use
      AppColors.primaryColor.withOpacity(0.12),
    ),
    dayShape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
      ),
    ),

    // Today
    todayForegroundColor: WidgetStateProperty.all(Colors.white),
    todayBackgroundColor: WidgetStateProperty.all(AppColors.inputFieldColor),
    todayBorder: const BorderSide(color: AppColors.primaryColor),

    // Year
    yearStyle: const TextStyle(color: AppColors.primaryTextColor, fontSize: 14),
    yearForegroundColor: WidgetStateProperty.all(AppColors.primaryTextColor),
    yearBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    yearOverlayColor: WidgetStateProperty.all(
      // ignore: deprecated_member_use
      AppColors.primaryColor.withOpacity(0.12),
    ),
    yearShape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
      ),
    ),

    // Range Picker
    rangePickerBackgroundColor: AppColors.backgroundColor,
    rangePickerElevation: 4,
    rangePickerShadowColor: Colors.black26,
    rangePickerSurfaceTintColor: AppColors.backgroundColor,
    rangePickerShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingContainerM),
    ),
    rangePickerHeaderBackgroundColor: AppColors.primaryColor,
    rangePickerHeaderForegroundColor: Colors.white,
    rangePickerHeaderHeadlineStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    rangePickerHeaderHelpStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    // ignore: deprecated_member_use
    rangeSelectionBackgroundColor: AppColors.primaryColor.withOpacity(0.24),
    rangeSelectionOverlayColor: WidgetStateProperty.all(
      // ignore: deprecated_member_use
      AppColors.primaryColor.withOpacity(0.12),
    ),

    // Divider & Input
    dividerColor: AppColors.inputFieldColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(AppSizes.paddingContainerS),
      ),
    ),

    // Buttons
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
    ),

    // Locale
    locale: const Locale('tr', 'TR'),
  );
}
