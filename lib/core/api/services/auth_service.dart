import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../api.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';

class AuthService {
  Future<TokenModel> login(
      {required String phone, required String password}) async {
    final url = Uri.http(API.host, API.login);
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    final body = json.encode({"phone": "+993$phone", "password": password});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return TokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable login");
    }
  }

  Future<UserModel> profile() async {
    final url = Uri.http(API.host, API.profile);
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${API.userToken}"
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable get user profile");
    }
  }
}
