import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taxipark_driver/core/style/palette.dart';

import 'slidable_button.dart';

class MySlidable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onCancelled;
  final VoidCallback? onView;
  const MySlidable(
      {super.key, required this.child, this.onCancelled, this.onView});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.35,
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (onCancelled != null)
                SlidableButton(
                    icon: Icons.delete, color: Colors.red, onTap: onCancelled),
              if (onView != null) const SizedBox(height: 10),
              if (onView != null)
                SlidableButton(
                    onTap: onView,
                    color: Palette.yellow,
                    icon: Icons.remove_red_eye_rounded)
            ],
          ),
        ],
      ),
      child: child,
    );
  }
}
