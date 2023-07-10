import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/api/models/user_model.dart';
import 'package:taxipark_driver/core/preferences/preference_keys.dart';
import 'package:taxipark_driver/core/preferences/preferences_util.dart';

import '../api.dart';
import '../models/token_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final PreferenceManager cache = PreferenceManager.instance;
  UserModel? _model;
  UserModel? get model => _model;
  String? token;
  bool isLoggedIn = false;
  String _username = "";
  String _phoneNumber = "";
  String _password = "";

  String get username => _username;
  String get phoneNumber => _phoneNumber;
  String get password => _password;
  initData({VoidCallback? onSuccess, VoidCallback? onError}) {
    _password = cache.getStringValue(PreferenceKeys.USER_PASS);
    _phoneNumber = cache.getStringValue(PreferenceKeys.USER_PHONE);
    if (_phoneNumber.isEmpty || _password.isEmpty) return onError?.call();
    if (_phoneNumber.isNotEmpty && _password.isNotEmpty) {
      return login(
          phoneNumber: _phoneNumber,
          password: _password,
          onError: onError,
          onLogin: () {
            onSuccess?.call();
            updateFCM.call();
            profile.call();
          });
    }
    // });
  }

  setToken(value) {
    token = value;
    API.userToken = value;
    notifyListeners();
  }

  setLogin(value) {
    isLoggedIn = value;
    notifyListeners();
  }

  _saveInCache() {
    API.userToken = token ?? "";
    cache.setStringValue(PreferenceKeys.USER_FULLNAME, _username);
    cache.setStringValue(PreferenceKeys.USER_PHONE, _phoneNumber);
    cache.setStringValue(PreferenceKeys.USER_PASS, _password);
    cache.setStringValue(PreferenceKeys.USER_TOKEN, token ?? '');
  }

  _handleResponseData({
    required dynamic responseData,
    Function? onDone,
    Function? onPasswordIncorrect,
  }) {
    if (responseData is TokenModel) {
      isLoggedIn = true;
      token = responseData.token;

      _saveInCache();
      notifyListeners();
      onDone?.call();
      profile.call();
    } else {
      // debugPrint("error message: ${responseData['error']}");
      onPasswordIncorrect?.call();
    }
  }

  logout({Function? onSuccess}) {
    isLoggedIn = false;
    API.userToken = "";
    onSuccess?.call();
    notifyListeners();
    cache.clearAll();
  }

  login({
    required String phoneNumber,
    required String password,
    VoidCallback? onLogin,
    VoidCallback? onError,
    VoidCallback? onPasswordIncorrect,
  }) {
    return AuthService()
        .login(phone: phoneNumber, password: password)
        .then((res) async {
      _phoneNumber = phoneNumber;
      _password = password;

      _handleResponseData(
        responseData: res,
        onDone: onLogin,
        onPasswordIncorrect: onPasswordIncorrect,
      );
    }).catchError((err) {
      debugPrint("I am in auth provider: $err");
      onError?.call();
    });
  }

  profile({Function? onSuccess}) {
    return AuthService().profile().then((value) {
      _username = value.username ?? "";
      _phoneNumber = value.phone ?? "";
      _model = value;
      onSuccess?.call();
      notifyListeners();
    }).catchError((err) {
      debugPrint("Get profile error: $err");
    });
  }

  updateFCM() async {
    if (API.userToken.isEmpty) return;
    String? token = await FirebaseMessaging.instance.getToken() ?? 'no';
    await AuthService().updateFcm(token: token).then((res) {
      return;
    }).catchError((err) {
      debugPrint("I am in auth provider: $err");
    });
  }

  changeAvailability(
      {required bool availability, Function? onSuccess, Function? onError}) {
    return AuthService()
        .updateMe(body: {"isAvailable": availability}).then((value) {
      _model = value;
      notifyListeners();
      onSuccess?.call();
    }).catchError((err) {});
  }
  //TODO: I will need a GSM modem

  // getSmsData(
  //     {required String telephone,
  //     required String text,
  //     Function? onUserAlreadyExists,
  //     Function? onSuccess}) {
  //   return AuthService()
  //       .getSMSData(phoneNumber: telephone, password: text)
  //       .then((value) {
  //     if (value['status'] == '200' && onSuccess != null) {
  //       _servicePhone = value['telephone'];
  //       _tempCode = value['code'];
  //       onSuccess.call();
  //     } else if (value['status'] == '201' && onUserAlreadyExists != null) {
  //       if (value['token'] != '') token = value['token'];
  //       onUserAlreadyExists.call();
  //     }
  //   });
  // }
}
