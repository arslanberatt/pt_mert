import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  static InputDecorationTheme lightTextFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF5F5F5), // Hafif gri arka plan
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none, // Border yok gibi
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
    ),
    hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
    labelStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 15,
    ),
    prefixIconColor: Colors.grey.shade500,
    suffixIconColor: Colors.grey.shade400,
  );
}
