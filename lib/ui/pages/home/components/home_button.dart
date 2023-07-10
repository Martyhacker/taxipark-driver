import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final int? badgeCount;
  const HomeButton({
    super.key,
    required this.onTap,
    required this.title,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        InkWell(
          borderRadius: kDefaultBorderRadius,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: size.width / 3,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
                color: Palette.yellow,
                boxShadow: Shadows.defaultShadow,
                borderRadius: kDefaultBorderRadius),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        if (badgeCount != null)
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ))
      ],
    );
  }
}
