import 'dart:convert';
import 'dart:io';

import 'package:taxipark_driver/core/api/api.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<Map<String, dynamic>> getOrders(
      {int limit = kLimit, int offset = 0}) async {
    final url = Uri.http(
        API.host, API.orders, {"limit": "$limit", "offset": "$offset"});
    final headers = {
      HttpHeaders.authorizationHeader: "Bearer ${API.userToken}",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return {
        "count": int.tryParse(jsonDecode(response.body)['count'].toString()),
        "data": jsonDecode(response.body)['data']
            .map<OrderModel>((e) => OrderModel.fromJson(e))
            .toList()
      };
    } else {
      throw Exception("Unable fetch orders");
    }
  }
}
