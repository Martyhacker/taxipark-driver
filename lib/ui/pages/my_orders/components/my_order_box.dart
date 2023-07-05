import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/palette.dart';

class MyOrderBox extends StatelessWidget {
  const MyOrderBox({
    super.key,
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
                      steps: const [
                        Step(
                            title: Text("Oguzkent oteli"), content: SizedBox()),
                        Step(title: Text("Gagarin 12/A"), content: SizedBox()),
                      ])),
              Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: kDefaultBorderRadius),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Palette.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
