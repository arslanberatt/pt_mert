import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_mert/screens/transaction/create_transaction_screen.dart';
import 'package:pt_mert/screens/transaction/widgets/setting_add_icon.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';
import 'package:pt_mert/screens/customer/widgets/customer_add_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? action;
  const CustomAppBar({super.key, this.action});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/boxing-logo.jpg"),
        ),
      ),
      actions: [
        ?action,
        SizedBox(width: AppSizes.spacingM),
        SettingAddWidget(),
        SizedBox(width: AppSizes.spacingS),
      ],
    );
  }
}
