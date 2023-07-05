import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';

class OrderDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onStartCounter;
  const OrderDetailAppBar({
    super.key,
    this.onStartCounter,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Palette.grey,
                shape: BoxShape.circle,
                boxShadow: Shadows.defaultShadow,
              ),
              child: const Icon(Icons.arrow_back),
            ),
          )),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    boxShadow: Shadows.defaultShadow,
                    color: Palette.yellow,
                    borderRadius: kDefaultBorderRadius),
                child: const Text("Start counter"),
              ))
        ],
      ),
    );
  }

  @override
  final Size preferredSize;
}
