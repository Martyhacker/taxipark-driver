import 'dart:convert';
import 'dart:io';

import 'package:taxipark_driver/core/api/api.dart';
import 'package:taxipark_driver/core/api/models/statistics_model.dart';
import 'package:http/http.dart' as http;

class StatisticsService {
  Future<StatisticsModel> getStatistics() async {
    final url = Uri.http(API.host, API.statistics);
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${API.userToken}"
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return StatisticsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable get statistics");
    }
  }
}
