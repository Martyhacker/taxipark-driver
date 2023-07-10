import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxipark_driver/core/api/services/auth_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  set setCurrentPosition(Position pos) {
    _currentPosition = pos;
    notifyListeners();
  }

  Future<bool> checkPermissions() async {
    bool result = false;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      result = false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permissions are denied");
        result = false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      result = false;
      debugPrint(
          "Location permissions are permanently denied, we cannot request permissions.");
    }
    return result;
  }

  getLocation({Function? onPermissionError, Function? onError}) {
    return checkPermissions().then((value) {
      if (value) {
        onPermissionError?.call();
      } else {
        Geolocator.getCurrentPosition().then((value) {
          _currentPosition = value;
          // FlutterCompass.events?.first.then((compass) {
          //   setCurrentPosition = Position(
          //       longitude: value.longitude,
          //       latitude: value.latitude,
          //       timestamp: value.timestamp,
          //       accuracy: value.accuracy,
          //       altitude: value.altitude,
          //       heading: compass.heading ?? 0,
          //       speed: value.speed,
          //       speedAccuracy: value.speedAccuracy);
          //   debugPrint("Compass error: ${compass.heading}");
          // }).catchError((err) {
          //   debugPrint("Compass error: $err");
          //   onError?.call();
          // });
          _updateDriverPosition();
          debugPrint(value.heading.toString());
        }).catchError((err) {
          onError?.call();
        });
      }
    }).catchError((err) {
      onError?.call();
    });
  }

  _updateDriverPosition({Function? onSuccess, Function? onError}) {
    if (_currentPosition == null) return;
    return AuthService()
        .updateLocation(position: _currentPosition!)
        .then((value) {
      if (value) {
        onSuccess?.call();
      } else {
        onError?.call();
      }
    }).catchError((err) {
      onError?.call();
      debugPrint("Update position error: $err");
    });
  }
}
