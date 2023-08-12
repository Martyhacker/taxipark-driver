import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../constants/dev_constants.dart';

class TelephonyUtil {
  static Future<void> call(String phoneNumber) async {
    final url = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(url);
  }

  static Future<void> sms(String phone, body) async {
    final seperator = Platform.isIOS ? '&' : '?';
    final androidUrl = Uri(
        scheme: 'sms',
        path: phone,
        queryParameters: {'body': Uri.encodeComponent(body)});
    final iosUrl =
        Uri.parse('sms:${Uri.encodeComponent('$phone$seperator$body=$body')}');
    launchUrl(Platform.isIOS ? iosUrl : androidUrl);
  }

  static Future<void> mail(String mail) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
      query: '',
    );

    launchUrl(emailLaunchUri);
  }

  static Future<void> browse(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> rateApp() async {
    final androidUrl = Uri.parse(DevConstants.playStore);
    launchUrl(androidUrl, mode: LaunchMode.externalApplication);
  }
}
