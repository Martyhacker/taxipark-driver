import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/style/icon_assets.dart';
import '../../core/style/palette.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const DefaultAppBar({super.key,  this.actions, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(IconAssets.arrowLeft,
                // ignore: deprecated_member_use
                color: Palette.black,
                fit: BoxFit.scaleDown)),
        title: Text(
          title,
          style: const TextStyle(color: Palette.black),
        ),
        actions: actions);
  }

  @override
  final Size preferredSize;
}
