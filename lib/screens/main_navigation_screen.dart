import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/cubits/main_navigation_cubit.dart';
import 'package:pt_mert/screens/home/appointment_screen.dart';
import 'package:pt_mert/screens/home/home_screen.dart';
import 'package:pt_mert/screens/setting/setting_screen.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainNavigationCubit(),
      child: const _MainNavigationView(),
    );
  }
}

class _MainNavigationView extends StatelessWidget {
  const _MainNavigationView({super.key});

  static final _pages = [HomeScreen(), AppointmentScreen(), SettingsScreen()];

  static final _icons = [Icons.home, Icons.add, Icons.settings];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainNavigationCubit, int>(
        builder: (context, index) {
          return IndexedStack(index: index, children: _pages);
        },
      ),
      bottomNavigationBar: BlocBuilder<MainNavigationCubit, int>(
        builder: (context, index) {
          return AnimatedBottomNavigationBar(
            icons: _icons,
            activeIndex: index,
            onTap: (i) => context.read<MainNavigationCubit>().changeTab(i),
            borderWidth: 1,
            borderColor: AppColors.inputFieldColor,
            backgroundColor: AppColors.backgroundColor,
            activeColor: AppColors.blackTextColor,
            inactiveColor: AppColors.inputFieldColor,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.defaultEdge,
            leftCornerRadius: 16,
            rightCornerRadius: 16,
          );
        },
      ),
    );
  }
}
