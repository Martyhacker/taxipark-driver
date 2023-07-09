import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/utils/notification_util.dart';

import 'splash_components/splash_elements.dart';
import 'splash_components/splash_no_internet.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _notificationUtil = NotificationUtil();
  @override
  void initState() {
    super.initState();
    _notificationUtil.initNotificationUtil(
        onSelectNotification: (v) {}, context: context);
    FirebaseMessaging.onMessage.listen(
        (RemoteMessage msg) => _notificationUtil.showNotification(msg: msg));
    FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage msg) => _notificationUtil.showNotification(msg: msg));
    initTimer();
  }

  initTimer() async {
    if (await checkInternet()) {
      Future.delayed(const Duration(seconds: 2), () async {
        initAllData();
      });
    } else {}
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  initAllData() {
    messaging.subscribeToTopic("elite-taxi-drivers");
    debugPrint("Init all data");
    context.read<AuthProvider>().initData(onError: () {
      Navigator.pushReplacementNamed(context, Routes.login);
    }, onSuccess: () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: FutureBuilder(
              future: checkInternet(),
              builder: (context, snap) {
                if (snap.data == null) {
                  return const SplashElements();
                } else if (snap.data == true) {
                  return const SplashElements();
                } else {
                  return SplashNoInternet(onRetry: initTimer);
                }
              })),
    );
  }
}
