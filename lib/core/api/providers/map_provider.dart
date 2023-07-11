import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  final _mapController = MapController();
  MapController get mapController => _mapController;

  moveCamera(LatLng? coordinates) {
    if (coordinates == null) return;
    _mapController.move(coordinates, 15);
    notifyListeners();
  }
}
