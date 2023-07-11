import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/style/shadows.dart';

class SlidableButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;
  final IconData icon;
  const SlidableButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.red,
            boxShadow: Shadows.defaultShadow),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
