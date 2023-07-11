import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';

class StatisticBox extends StatelessWidget {
  final String title;
  final num count;
  const StatisticBox({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Palette.yellow,
          borderRadius: kDefaultBorderRadius,
          boxShadow: Shadows.defaultShadow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          AnimatedFlipCounter(
            value: count,
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
