import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/routes/transitions/slide_route.dart';
import 'package:taxipark_driver/ui/pages/index.dart';
import 'package:taxipark_driver/ui/pages/order_detail/order_detail_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return SlideLeftRoute(page: const SplashPage(), settings: settings);
      case Routes.home:
        return SlideLeftRoute(page: const HomePage(), settings: settings);
      case Routes.login:
        return SlideLeftRoute(page: const LoginPage(), settings: settings);
      case Routes.profile:
        return SlideLeftRoute(page: const ProfilePage(), settings: settings);
      case Routes.myOrders:
        return SlideLeftRoute(page: const MyOrdersPage(), settings: settings);
      case Routes.orderDetail:
        return SlideLeftRoute(
            page: const OrderDetailPage(), settings: settings);
      default:
        return SlideLeftRoute(page: const ErrorRoute(), settings: settings);
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'USSA TM',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: SingleChildScrollView(
            child: Text(
          'Страница не найдена!',
        )),
      ),
    );
  }
}
