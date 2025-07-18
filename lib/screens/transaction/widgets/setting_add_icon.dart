import 'package:flutter/material.dart';
import 'package:pt_mert/screens/setting/setting_screen.dart';

class SettingAddWidget extends StatelessWidget {
  const SettingAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SettingsScreen()),
        );
      },
      icon: const Icon(Icons.settings, color: Colors.black87),
    );
  }
}
