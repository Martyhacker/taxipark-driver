import 'dart:convert';
import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../../preferences/preference_keys.dart';
import '../../preferences/preferences_util.dart';
import '../../utils/encryption.dart';
import '../api.dart';
import '../models/my_route_model.dart';

class FinderServices {
  static String fsociety = utf8.decode(base64Decode(
      PreferenceManager.instance.getSStringValue(PreferenceKeys.FSUX)));
  Future<MyRouteModel> findRoute(
      {required LatLng start, required LatLng end}) async {
    final url = Uri.http(API.host, API.path);
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${API.userToken}"
    };
    final body = json.encode({
      "pointA": {"lat": start.latitude, "lng": start.longitude},
      "pointB": {"lat": end.latitude, "lng": end.longitude}
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      var json = jsonDecode(decryptAESCryptoJS(response.body, fsociety));
      return MyRouteModel.fromJson(json);
    } else {
      throw Exception("Unable get route");
    }
  }
}
