import 'package:flutter/material.dart';

Widget SummaryCard(
  String title,
  double amount,
  Color bgColor,
  Color textColor,
) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            "₺${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
