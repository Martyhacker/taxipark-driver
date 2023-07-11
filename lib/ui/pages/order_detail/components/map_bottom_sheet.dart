import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';
import 'package:taxipark_driver/ui/widgets/dialogs/ok_dialog.dart';
import 'package:taxipark_driver/ui/widgets/main_button.dart';
import 'dart:io' show Platform;

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Palette.grey, borderRadius: BorderRadius.circular(50)),
          ),
          Column(
            children: [
              Text(
                'Поступивший заказ',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                      color: Palette.white, borderRadius: kDefaultBorderRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'от',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            filled: true,
                            fillColor: Palette.lightGrey,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      Text(
                        'до',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            filled: true,
                            fillColor: Palette.lightGrey,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      Text(
                        'Номер клиента',
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
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ],
                  )),
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: (_) => OkDialog(
                                    title: "Отменить",
                                    content: "Вы хотите отменить этот заказ?",
                                    onOkTap: () {}))
                            : showDialog(
                                context: context,
                                builder: (_) => OkDialog(
                                    title: "Отменить",
                                    content: "Вы хотите отменить этот заказ??",
                                    onOkTap: () {}));
                      },
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
                        child:
                            MainButton(onTap: () {}, text: 'Заказ выполнен')),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
