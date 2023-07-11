import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/models/my_route_model.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/api/providers/finder_provider.dart';
import 'package:taxipark_driver/core/api/providers/location_provider.dart';
import 'package:taxipark_driver/core/api/providers/map_provider.dart';
import 'package:taxipark_driver/core/api/providers/order_provider.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/ui/pages/order_detail/components/order_detail_appbar.dart';

import 'components/map_bottom_sheet.dart';

class OrderDetailMapPage extends StatefulWidget {
  const OrderDetailMapPage({super.key});

  @override
  State<OrderDetailMapPage> createState() => _OrderDetailMapPageState();
}

class _OrderDetailMapPageState extends State<OrderDetailMapPage> {
  @override
  void initState() {
    super.initState();
    OrderModel? order = context.read<OrderProvider>().order;
    if (order != null &&
        order.startLat != null &&
        order.startLon != null &&
        order.destLat != null &&
        order.destLon != null) {
      context.read<FinderProvider>().findRoute(
          start: LatLng(order.startLat!, order.startLon!),
          end: LatLng(order.destLat!, order.destLon!));
    }
  }

  @override
  Widget build(BuildContext context) {
    OrderModel? model = context.watch<OrderProvider>().order;
    MyRouteModel? route = context.watch<FinderProvider>().foundRoute;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const OrderDetailAppBar(),
      bottomSheet: 1 == 1 ? null : const MapBottomSheet(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.read<LocationProvider>().currentPosition == null) return;
          LatLng? point = LatLng(
              context.read<LocationProvider>().currentPosition!.latitude,
              context.read<LocationProvider>().currentPosition!.longitude);
          context.read<MapProvider>().moveCamera(point);
        },
        child: SvgPicture.asset(IconAssets.gps),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: context.watch<MapProvider>().mapController,
            options: MapOptions(
                maxBounds: kMaxBounds,
                center: (model != null &&
                        model.startLat != null &&
                        model.startLon != null)
                    ? LatLng(model.startLat!, model.startLon!)
                    : kDefaultLocation),
            children: [
              TileLayer(
                  urlTemplate:
                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
              if (model != null)
                MarkerLayer(
                  markers: [
                    if (model.startLat != null && model.startLon != null)
                      Marker(
                          point: LatLng(model.startLat!, model.startLon!),
                          builder: (_) =>
                              SvgPicture.asset(IconAssets.location)),
                    if (model.destLat != null && model.destLon != null)
                      Marker(
                          point: LatLng(model.destLat!, model.destLon!),
                          builder: (_) =>
                              SvgPicture.asset(IconAssets.location)),
                  ],
                ),
              if (route != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                        strokeWidth: 2,
                        color: Colors.black,
                        points: context
                            .read<FinderProvider>()
                            .foundRoute!
                            .routes![0]
                            .legs![0]
                            .steps!
                            .map((e) => LatLng(e.maneuver?.location![1] ?? 37,
                                e.maneuver?.location![0] ?? 58))
                            .toList()),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
