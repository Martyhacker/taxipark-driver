import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/routes/generator.dart';
import 'package:taxipark_driver/core/use_case/no_network_widget.dart';

import 'core/api/providers/index.dart';
import 'core/preferences/preferences_util.dart';
import 'core/routes/routes.dart';
import 'core/utils/language_singletone.dart';

Future<void> main() async {
  await _init();
  runApp(EasyLocalization(
    supportedLocales: LanguageManager.instance?.supportedLocales ?? [],
    path: "assets/translations",
    fallbackLocale: LanguageManager.instance?.tmLocale,
    startLocale: LanguageManager.instance?.tmLocale,
    saveLocale: true,
    child: MultiProvider(
        providers: [...AppProviders.instance?.allProviders ?? []],
        child: const MyApp()),
  ));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PreferenceManager.prefrencesInit();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return MaterialApp(
      title: 'TaxiPark',
      theme: ThemeData(primarySwatch: Colors.blue),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
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

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
