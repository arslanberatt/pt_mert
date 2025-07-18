import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_mert/screens/transaction/widgets/customer_list_icon.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

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
        SizedBox(width: AppSizes.spacingS),
        CustomerListWidget(),
        SizedBox(width: AppSizes.spacingS),
      ],
    );
  }
}
