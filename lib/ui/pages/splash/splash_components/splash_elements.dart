import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taxipark_driver/core/style/image_assets.dart';
import 'package:taxipark_driver/core/style/lottie_assets.dart';

class SplashElements extends StatelessWidget {
  const SplashElements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 8,
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(ImageAssets.logo)),
        ),
        // LinearProgressIndicator(
        //     color: Palette.lightOrange, backgroundColor: Palette.lightGrey),

        Expanded(
          child: LottieBuilder.asset(
            LottieAssets.splashLoading,
            width: size.width / 3,
          ),
        )
      ],
    );
  }
}
