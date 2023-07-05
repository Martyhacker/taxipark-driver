// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:taxipark_driver/core/api/models/address_model.dart';
// import 'package:taxipark_driver/core/api/models/my_route_model.dart';
// import 'package:taxipark_driver/core/api/services/finder_services.dart';

// class FinderProvider extends ChangeNotifier {
//   MyRouteModel? _foundRoute;
//   MyRouteModel? get foundRoute => _foundRoute;

//   final List<AddressModel> _searchResults = [];
//   List<AddressModel> get searchResults => _searchResults;

//   findRoute({required LatLng start, required LatLng end}) {
//     _searchResults.clear();
//     return FinderServices().findRoute(start: start, end: end).then((value) {
//       _foundRoute = value;
//       notifyListeners();
//     }).catchError((err) {
//       debugPrint("Route find error: $err");
//     });
//   }

//   findPlaceByKeyword({required String keyword}) {
//     return FinderServices().findPointByKeyword(keyword: keyword).then((value) {
//       _searchResults.addAll(value);
//       notifyListeners();
//     }).catchError((err) {
//       debugPrint("Search keyword error: $err");
//     });
//   }
// }
