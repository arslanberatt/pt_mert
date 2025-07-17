import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class ClassicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? action;

  const ClassicAppBar({super.key, this.action});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      title: const Text(
        "PT Mert",
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      actions: [?action],
    );
  }
}
