import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
// import 'package:taxipark_driver/core/api/providers/finder_provider.dart';
import 'package:taxipark_driver/core/api/providers/map_procider.dart';
import 'package:taxipark_driver/core/api/providers/modal_provider.dart';
// import 'package:taxipark_driver/core/api/providers/picked_point_provider.dart';

class AppProviders {
  AppProviders._init();
  static AppProviders? _instance;
  static AppProviders? get instance {
    _instance ??= AppProviders._init();
    return _instance;
  }

  List<SingleChildWidget> allProviders = [
    // ChangeNotifierProvider(create: (_)=> LocationProvider()),
    ChangeNotifierProvider<ModalProvider>(create: (_) => ModalProvider()),
    // ChangeNotifierProvider<PickedPointProvider>(
    //     create: (_) => PickedPointProvider()),
    // ChangeNotifierProvider<FinderProvider>(create: (_) => FinderProvider()),
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<MapProvider>(create: (_) => MapProvider())
  ];
}
