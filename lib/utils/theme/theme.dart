import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/theme/widget_themes/app_bar_theme.dart';
import 'package:pt_mert/utils/theme/widget_themes/dialog_theme.dart';
import 'package:pt_mert/utils/theme/widget_themes/dropdown_theme.dart';
import 'package:pt_mert/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:pt_mert/utils/theme/widget_themes/picker_theme.dart';
import 'package:pt_mert/utils/theme/widget_themes/text_field_theme.dart';
import 'package:pt_mert/utils/theme/widget_themes/time_picker_theme.dart';

class CustomTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: AppColors.blackTextColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,

    appBarTheme: CustomAppBarTheme.light,
    dialogTheme: CustomDialogTheme.light,
    dropdownMenuTheme: CustomDropdownTheme.light,
    elevatedButtonTheme: CustomElevatedButtonTheme.light,
    inputDecorationTheme: CustomTextFieldTheme.lightTextFieldTheme,
    datePickerTheme: CustomDatePickerTheme.light,
    timePickerTheme: CustomTimePickerTheme.light,
  );
}
