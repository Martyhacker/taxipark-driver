// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';
// import 'package:taxipark_driver/core/api/providers/map_procider.dart';
// import 'package:taxipark_driver/core/api/providers/modal_provider.dart';
// import 'package:taxipark_driver/core/constants/constants.dart';
// import 'package:taxipark_driver/core/style/icon_assets.dart';
// import '../../widgets/app_drawer.dart';
// import 'components/home_appbar.dart';
// import 'components/home_bottombar.dart';
// import 'dart:math' as math;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Position? _currentPosition;
//   // final MapPickerController _mapPickerController = MapPickerController();
//   // late final _mapController = MapController();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   double _rotation = 0;

//   getLoc() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       debugPrint("Location services are disabled.");
//       // return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // return Future.error('Location permissions are denied');
//         debugPrint("Location permissions are denied");
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       debugPrint(
//           "Location permissions are permanently denied, we cannot request permissions.");
//       // return Future.error(
//       //     'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // return await Geolocator.getCurrentPosition();

//     _currentPosition = await Geolocator.getCurrentPosition();
//     debugPrint("${_currentPosition!.latitude}, ${_currentPosition!.longitude}");
//     context.read<MapProvider>().moveCamera(LatLng(
//         _currentPosition?.latitude ?? kDefaultLocation.latitude,
//         _currentPosition?.longitude ?? kDefaultLocation.longitude));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // bool isModalOpen =
//     //     context.watch<ModalProvider>().modalType != ModalType.none;
//     LatLng? pointA = context.watch<PickedPointProvider>().pointA;
//     LatLng? pointB = context.watch<PickedPointProvider>().pointB;
//     MapController mapController = context.watch<MapProvider>().mapController;
//     return Scaffold(
//         key: _scaffoldKey,
//         extendBodyBehindAppBar: true,
//         extendBody: true,
//         drawer: const AppDrawer(),
//         appBar: HomeAppBar(onLocationTap: () => getLoc()),
//         body: Stack(
//           children: [
//             FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//                   onPositionChanged: (position, _) {
//                     setState(() {
//                       _rotation = mapController.rotation;
//                     });
//                   },
//                   onTap: (position, point) {
//                     if (context.read<ModalProvider>().modalType ==
//                         ModalType.from) {
//                       context.read<PickedPointProvider>().setPointA(point);
//                     } else if (context.read<ModalProvider>().modalType ==
//                         ModalType.where) {
//                       context.read<PickedPointProvider>().setPointB(point);
//                     }
//                   },
//                   center: kDefaultLocation,
//                   zoom: 15,
//                   // minZoom: 15,
//                   // maxZoom: 50,
//                   maxBounds: kMaxBounds,
//                   screenSize: MediaQuery.of(context).size),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 ),
//                 if (context.watch<PickedPointProvider>().routeBetweenPoints !=
//                     null)
//                   PolylineLayer(
//                     polylines: [
//                       Polyline(
//                           strokeWidth: 2,
//                           color: Colors.black,
//                           // isDotted: true,
//                           points: context
//                               .read<PickedPointProvider>()
//                               .routeBetweenPoints!
//                               .routes![0]
//                               .legs![0]
//                               .steps!
//                               .map((e) => LatLng(e.maneuver?.location![1] ?? 37,
//                                   e.maneuver?.location![0] ?? 58))
//                               .toList()),
//                     ],
//                   ),
//                 if (_currentPosition != null)
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         rotate: false,
//                         width: 100,
//                         height: 100,
//                         point: LatLng(_currentPosition?.latitude ?? 38,
//                             _currentPosition?.longitude ?? 58),
//                         builder: (_) => Transform.rotate(
//                           angle: -_rotation * math.pi / 180,
//                           child: const Icon(
//                             Icons.gps_fixed_outlined,
//                             color: Colors.blue,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       if (pointA != null)
//                         Marker(
//                             point: pointA,
//                             builder: (_) => Transform.rotate(
//                                   angle: -_rotation * math.pi / 180,
//                                   child: SvgPicture.asset(IconAssets.location),
//                                 ),
//                             width: 30,
//                             height: 30),
//                       if (pointB != null)
//                         Marker(
//                             point: pointB,
//                             builder: (_) => Transform.rotate(
//                                   angle: -_rotation * math.pi / 180,
//                                   child: SvgPicture.asset(IconAssets.location),
//                                 ),
//                             width: 30,
//                             height: 30)
//                     ],
//                   ),
//               ],
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: HomeBottomBar(scaffoldKey: _scaffoldKey),
//             ),
//           ],
//         ));
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/custom_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';
import 'package:taxipark_driver/generated/locale_keys.g.dart';
import 'package:taxipark_driver/ui/widgets/main_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconAssets.profile, color: Palette.yellow),
            Text(
              "Kemal",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            CustomRating(
              onRating: (v) {},
              score: 4,
              max: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: HomeButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.orderDetail);
                          },
                          title: LocaleKeys.home_viewOrders.tr(),
                          badgeCount: 2)),
                  Expanded(
                      child: HomeButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.myOrders);
                          },
                          title: LocaleKeys.home_finishedOrders.tr(),
                          badgeCount: 2)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                      child: HomeButton(
                          onTap: () {},
                          title: LocaleKeys.home_cancelledOrders.tr(),
                          badgeCount: 2)),
                  Expanded(
                      child: HomeButton(
                          onTap: () {}, title: LocaleKeys.home_orders.tr())),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  onTap: () {},
                  text: LocaleKeys.home_free.tr(),
                  padding: const EdgeInsets.all(15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final int? badgeCount;
  const HomeButton({
    super.key,
    required this.onTap,
    required this.title,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        InkWell(
          borderRadius: kDefaultBorderRadius,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: size.width / 3,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
                color: Palette.yellow,
                boxShadow: Shadows.defaultShadow,
                borderRadius: kDefaultBorderRadius),
            child: Text(title),
          ),
        ),
        if (badgeCount != null)
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ))
      ],
    );
  }
}
