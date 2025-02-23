import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool useAppHome;

  const CommonAppBar(
      {super.key, required this.title, required this.useAppHome});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: MyColors.mainFontColor),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (useAppHome) {
            context.go('/AppHome');
          } else {
            Navigator.of(context).pop();
          }
        },
        padding: EdgeInsets.zero,
        iconSize: 24,
      ),
      titleSpacing: -5.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
