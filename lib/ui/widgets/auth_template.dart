import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxipark_driver/core/style/image_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';

class AuthTemplate extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const AuthTemplate({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SvgPicture.asset(ImageAssets.logo),
          if (title != null)
            Text(
              title!,
              style: const TextStyle(color: Palette.yellow),
            ),
          ...children
        ],
      ),
    );
  }
}
