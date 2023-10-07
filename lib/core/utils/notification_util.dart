import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class INotificationUtil {
  showNotification({required RemoteMessage msg});
  Future<void> requestPermissions();
  initNotificationUtil(
      {required Function(String?)? onSelectNotification,
      required BuildContext context});
}

class NotificationUtil extends INotificationUtil {
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  // Future<String> _downloadAndSaveFile(String url, String fileName) async {
  //   final Directory? directory = await getExternalStorageDirectory();
  //   final String filePath = '${directory!.path}/$fileName.png';
  //   final http.Response response = await http.get(Uri.parse(url));

  //   final File file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }

  Future<void> _demoNotification({
    required String title,
    // String image = 'http://ussa.com.tm/img/secImg.png',
    required String body,
  }) async {
    // final String bigPicturePath = await _downloadAndSaveFile(
    //   image,
    //   'bigPicture',
    // );

    var iOSChannelSpecifics = DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      subtitle: body,
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '16072002-elite-taxi-driver', 'elite-taxi-driver-notifier-channel',
        channelDescription: 'elite-taxi notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showProgress: true,
        sound: const RawResourceAndroidNotificationSound('slow_spring_board'),
        // largeIcon: FilePathAndroidBitmap(bigPicturePath),
        // color: kSoftGreen,
        styleInformation: BigTextStyleInformation(body,
            contentTitle: '<b>$title</b>',
            htmlFormatBigText: true,
            htmlFormatContent: true,
            htmlFormatContentTitle: true,
            summaryText: body)
        // styleInformation: BigPictureStyleInformation(
        //   FilePathAndroidBitmap(bigPicturePath),
        //   hideExpandedLargeIcon: false,
        //   contentTitle: '<b>$title</b>', // 'overridden <b>big</b> content title',
        //   htmlFormatContentTitle: true,
        //   summaryText: body, // 'summary <i>text</i>',
        //   htmlFormatSummaryText: true,
        // ),
        );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await plugin.show(0, title, body, platformChannelSpecifics);
  }

  @override
  showNotification({required RemoteMessage msg}) async {
    RemoteNotification? notification = msg.notification;
    await _demoNotification(
      title: notification?.title ?? 'No title',
      // image: msg.data['image'].toString(),
      body: notification?.body ?? 'No body',
    );
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          )
          .catchError((err) {
        debugPrint("IOS Notification permission error: $err");
        return false;
      });
      await plugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          )
          .catchError((err) {
        debugPrint("iOS notification permission error: $err");
        return false;
      });
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final bool granted = await plugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      if (!granted) {
        await androidImplementation?.requestPermission().catchError((err) {
          debugPrint("Android Notification Permission Error: $err");
          return false;
        });
      }
    }
  }

  @override
  initNotificationUtil(
      {required Function(String?)? onSelectNotification,
      required BuildContext context}) async {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings =
        InitializationSettings(android: android, iOS: iOS);
    await plugin.initialize(
      initializationSettings,
      //   onSelectNotification: (payload) {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const NotificationPage()));
      // }
    );
  }
}
