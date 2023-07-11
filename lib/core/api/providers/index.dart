import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
import 'package:taxipark_driver/core/api/providers/map_provider.dart';
import 'package:taxipark_driver/core/api/providers/statistics_provider.dart';

import 'finder_provider.dart';
import 'location_provider.dart';
import 'order_provider.dart';

class AppProviders {
  AppProviders._init();
  static AppProviders? _instance;
  static AppProviders? get instance {
    _instance ??= AppProviders._init();
    return _instance;
  }

  List<SingleChildWidget> allProviders = [
    ChangeNotifierProvider<LocationProvider>(create: (_) => LocationProvider()),
    // ChangeNotifierProvider<ModalProvider>(create: (_) => ModalProvider()),
    ChangeNotifierProvider<StatisticsProvider>(
        create: (_) => StatisticsProvider()),
    ChangeNotifierProvider<FinderProvider>(create: (_) => FinderProvider()),
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<MapProvider>(create: (_) => MapProvider()),
    ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
  ];
}
