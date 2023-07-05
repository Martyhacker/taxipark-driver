// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:taxipark_driver/core/api/models/my_route_model.dart';
// import 'package:taxipark_driver/core/api/services/finder_services.dart';

// class PickedPointProvider extends ChangeNotifier {
//   MyRouteModel? _routeBetweenPoints;
//   MyRouteModel? get routeBetweenPoints => _routeBetweenPoints;
//   LatLng? _pointA;
//   LatLng? _pointB;
//   LatLng? get pointA => _pointA;
//   LatLng? get pointB => _pointB;

//   reset() {
//     _pointA = null;
//     _pointB = null;
//     _routeBetweenPoints = null;
//     notifyListeners();
//   }

//   setPointA(LatLng point) {
//     _pointA = point;
//     notifyListeners();
//   }

//   setPointB(LatLng point) {
//     _pointB = point;
//     findRoute();
//     notifyListeners();
//   }

//   findRoute() {
//     if (_pointA == null || _pointB == null) return;
//     return FinderServices()
//         .findRoute(start: _pointA!, end: _pointB!)
//         .then((value) {
//       _routeBetweenPoints = value;
//       notifyListeners();
//     }).catchError((err) {
//       debugPrint("Point picker find route error: $err");
//     });
//   }
// }
