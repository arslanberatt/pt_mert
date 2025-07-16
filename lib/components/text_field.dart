import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget label;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final double spacing;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.keyboardType,
    this.hintText,
    this.spacing = 16,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            label: label,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorMsg,
          ),
        ),
        SizedBox(height: spacing),
      ],
    );
  }
}
