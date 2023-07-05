import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxipark_driver/core/api/models/my_route_model.dart';
import 'package:taxipark_driver/core/api/services/finder_services.dart';

class FinderProvider extends ChangeNotifier {
  MyRouteModel? _foundRoute;
  MyRouteModel? get foundRoute => _foundRoute;

  findRoute({required LatLng start, required LatLng end}) {
    return FinderServices().findRoute(start: start, end: end).then((value) {
      _foundRoute = value;
      notifyListeners();
    }).catchError((err) {
      debugPrint("Route find error: $err");
    });
  }
}
