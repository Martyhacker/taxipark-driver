import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';
import 'package:taxipark_driver/generated/locale_keys.g.dart';
import 'package:taxipark_driver/ui/pages/order_detail/components/order_detail_appbar.dart';
import 'package:taxipark_driver/ui/widgets/main_button.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const OrderDetailAppBar(),
      bottomSheet: 1 != 2
          ? null
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Palette.lightGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 8,
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                        color: Palette.grey,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Column(
                    children: [
                      Text(
                        LocaleKeys.orderDetail_incomingOrder.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius: kDefaultBorderRadius),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.orderDetail_from.tr(),
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    filled: true,
                                    fillColor: Palette.lightGrey,
                                    hintText: "Address...",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              Text(
                                LocaleKeys.orderDetail_to.tr(),
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    filled: true,
                                    fillColor: Palette.lightGrey,
                                    hintText: "Address...",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              Text(
                                LocaleKeys.orderDetail_phone.tr(),
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    filled: true,
                                    fillColor: Palette.lightGrey,
                                    hintText: "+99362980257",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: kToolbarHeight,
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    boxShadow: Shadows.defaultShadow,
                                    color: Palette.yellow,
                                    borderRadius: kDefaultBorderRadius),
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            Expanded(
                                flex: 4,
                                child: MainButton(
                                    onTap: () {},
                                    text: LocaleKeys.orderDetail_orderFinished
                                        .tr())),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
      body: Stack(
        children: [
          FlutterMap(
            options:
                MapOptions(maxBounds: kMaxBounds, center: kDefaultLocation),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              )
            ],
          ),
        ],
      ),
    );
  }
}
