import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onTap,
    required this.text,
    this.padding,
    this.margin,
  });

  final Function() onTap;
  final String text;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        margin: margin ?? const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            boxShadow: Shadows.defaultShadow,
            color: Palette.yellow,
            borderRadius: kDefaultBorderRadius),
        child: Text(
          text,
          style: const TextStyle(color: Palette.white),
        ),
      ),
    );
  }
}
