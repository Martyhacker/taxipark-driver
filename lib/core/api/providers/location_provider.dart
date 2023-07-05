// import 'package:flutter/foundation.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';

// class LocationProvider extends ChangeNotifier {
//   LatLng _latLng = LatLng(37, 58);
//   LatLng get latLng => _latLng;
//   final _location = Location();

//   getLocation({Function? onSuccess}) {
//     _location.hasPermission().then((granted) {
//       if (granted == PermissionStatus.granted ||
//           granted == PermissionStatus.grantedLimited) {
//         _location.getLocation().then((value) {
//           _latLng = LatLng(value.latitude ?? 37, value.longitude ?? 58);
//           onSuccess?.call();
//           notifyListeners();
//         }).catchError((err) {
//           debugPrint("Location provider error: $err");
//         });
//       }
//     });
//   }
// }
