import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_star/custom_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/models/statistics_model.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
import 'package:taxipark_driver/core/api/providers/location_provider.dart';
import 'package:taxipark_driver/core/api/providers/statistics_provider.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/ui/pages/home/components/availibility_button.dart';
import 'package:taxipark_driver/ui/pages/my_orders/my_orders_page.dart';

import 'components/home_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;
  Timer? t;
  _onSuccess() {
    context.read<LocationProvider>().getLocation(onError: () {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          const SnackBar(content: Text('Задача успешно выполнена!')));
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<LocationProvider>().checkPermissions();
    t = Timer.periodic(const Duration(seconds: 5), (timer) {
      context.read<LocationProvider>().getLocation(onError: () {
        ScaffoldMessenger.maybeOf(context)
            ?.showSnackBar(const SnackBar(content: Text('Произошла ошибка!')));
      }, onPermissionError: () {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(const SnackBar(
            content: Text("Пожалуйста, дайте разрешения на местоположение.")));
      });
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatisticsModel? statistics = context.watch<StatisticsProvider>().model;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            InkWell(
                onTap: () {
                  int now = DateTime.now().millisecondsSinceEpoch;
                  if (now - lastTap < 1000) {
                    consecutiveTaps++;
                    if (consecutiveTaps > 4) {
                      consecutiveTaps = 0;
                      t?.cancel();
                      debugPrint("BOOM");
                    }
                  } else {
                    consecutiveTaps = 0;
                  }
                  lastTap = now;
                },
                child: SvgPicture.asset(IconAssets.profile,
                    // ignore: deprecated_member_use
                    color: Palette.yellow)),
            Text(
              context.watch<AuthProvider>().username,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (context.read<AuthProvider>().model != null)
              IgnorePointer(
                child: CustomRating(
                    onRating: (v) {},
                    score: context.watch<AuthProvider>().model?.rating ?? 0),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: HomeButton(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.myOrders,
                              arguments: const MyOrdersPageArgs(
                                  orderStatus: OrderStatus.ALL)),
                          title: 'Все заказы')),
                  Expanded(
                      child: HomeButton(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.myOrders,
                              arguments: const MyOrdersPageArgs(
                                  orderStatus: OrderStatus.COMPLETED)),
                          title: 'Выполненные заказы',
                          badgeCount: statistics?.orders?.completedOrders)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                      child: HomeButton(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.myOrders,
                              arguments: const MyOrdersPageArgs(
                                  orderStatus: OrderStatus.WAITING)),
                          title: 'Заказы в ожидании',
                          badgeCount: statistics?.orders?.waitingOrders)),
                  Expanded(
                      child: HomeButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.statistics);
                          },
                          title: 'Statistics')),
                ],
              ),
            ),
            if (context.watch<AuthProvider>().model != null)
              AvailibilityButton(onTap: () {
                context.read<AuthProvider>().changeAvailability(
                    availability:
                        !(context.read<AuthProvider>().model?.isAvailable ??
                            true),
                    onSuccess: () => _onSuccess.call());
              })
          ],
        ),
      ),
    );
  }
}
