import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onFabTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onFabTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconList = <IconData>[
      Icons.dashboard_outlined,
      Icons.settings_outlined,
    ];

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: currentIndex,
          onTap: onTap,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 36,
          rightCornerRadius: 36,
          backgroundColor: AppColors.primaryColor,
          activeColor: AppColors.backgroundColor,
          inactiveColor: AppColors.inputFieldColor,
          splashColor: AppColors.backgroundColor,
        ),
      ],
    );
  }
}
