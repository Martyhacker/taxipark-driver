import 'package:flutter/material.dart';
import 'package:flutter_star/custom_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';
import 'package:taxipark_driver/ui/widgets/main_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconAssets.profile, color: Palette.yellow),
            Text(
              "Kemal",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            CustomRating(
              onRating: (v) {},
              score: 4,
              max: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: HomeButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.orderDetail);
                          },
                          title: 'Просмотр заказа',
                          badgeCount: 2)),
                  Expanded(
                      child: HomeButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.myOrders);
                          },
                          title: 'Выполненные заказы',
                          badgeCount: 2)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                      child: HomeButton(
                          onTap: () {},
                          title: 'Отмененные заказы',
                          badgeCount: 2)),
                  Expanded(child: HomeButton(onTap: () {}, title: 'Заказы')),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  onTap: () {},
                  text: 'Свободный|Не свободный',
                  padding: const EdgeInsets.all(15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final int? badgeCount;
  const HomeButton({
    super.key,
    required this.onTap,
    required this.title,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        InkWell(
          borderRadius: kDefaultBorderRadius,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: size.width / 3,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
                color: Palette.yellow,
                boxShadow: Shadows.defaultShadow,
                borderRadius: kDefaultBorderRadius),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        if (badgeCount != null)
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ))
      ],
    );
  }
}
