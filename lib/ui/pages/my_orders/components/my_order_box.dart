import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';

class MyOrderBox extends StatelessWidget {
  final OrderModel model;
  const MyOrderBox({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(25),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: kDefaultBorderRadius,
        color: Palette.lightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Stepper(
                      margin: const EdgeInsets.all(0),
                      controlsBuilder: (context, details) {
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                            title: Text(model.start ?? ""),
                            content: const SizedBox()),
                        Step(
                            title: Text(model.destination ?? ""),
                            content: const SizedBox()),
                      ])),
              Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: kDefaultBorderRadius),
                  child: const Text(
                    'Отмена',
                    style: TextStyle(color: Palette.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
