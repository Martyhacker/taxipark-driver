import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/remote_config/remote_config_service.dart';
import 'package:taxipark_driver/core/routes/generator.dart';
import 'package:taxipark_driver/core/use_case/no_network_widget.dart';
import 'package:taxipark_driver/firebase_options.dart';

import 'core/api/providers/index.dart';
import 'core/preferences/preferences_util.dart';
import 'core/routes/routes.dart';

Future<void> main() async {
  await _init();
  runApp(MultiProvider(
      providers: [...AppProviders.instance?.allProviders ?? []],
      child: const MyApp()));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PreferenceManager.prefrencesInit();
  await RemoteConfigService().initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elite Taxi Driver',
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: (context, child) {
        return Scaffold(
          body: Column(children: [
            Expanded(child: child ?? const SizedBox()),
            const NoNetworkWidget()
          ]),
        );
      },
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: Routes.splash,
    );
  }
}
