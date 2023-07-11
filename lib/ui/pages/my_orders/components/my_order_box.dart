import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';
import 'package:taxipark_driver/ui/pages/order_detail/order_detail_page.dart';
import 'package:taxipark_driver/ui/widgets/dialogs/ok_dialog.dart';
import 'package:taxipark_driver/ui/widgets/slidable/my_slidable.dart';
import 'dart:io' show Platform;

class OrderBox extends StatelessWidget {
  final OrderModel model;
  const OrderBox({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return MySlidable(
      onCancelled: () {
        Platform.isIOS
            ? showCupertinoDialog(
                context: context,
                builder: (_) => OkDialog(
                    title: "Info",
                    content: "Are you sure cancel this order?",
                    onOkTap: () {}))
            : showDialog(
                context: context,
                builder: (_) => OkDialog(
                    title: "Info",
                    content: "Are you sure cancel this order?",
                    onOkTap: () {}));
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.orderDetail,
              arguments: OrderDetailPageArgs(model: model));
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                boxShadow: Shadows.defaultShadow,
                borderRadius: kDefaultBorderRadius,
                color: Palette.lightGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: SvgPicture.asset(IconAssets.gps),
                    title: Text(model.start ?? ""),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(IconAssets.gps),
                    title: Text(model.destination ?? ""),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Palette.black,
                    ),
                    title: Text(model.time ?? "Now"),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              right: 50,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: model.status == "COMPLETED"
                        ? Colors.green
                        : Colors.orange,
                    shape: BoxShape.circle,
                    boxShadow: Shadows.defaultShadow),
              ),
            )
          ],
        ),
      ),
    );
  }
}
