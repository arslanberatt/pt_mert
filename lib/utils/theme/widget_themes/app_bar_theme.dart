import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomAppBarTheme {
  static final light = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontFamily: 'Archivo',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.blackTextColor,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
