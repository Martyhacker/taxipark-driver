import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxipark_driver/generated/locale_keys.g.dart';

class SplashNoInternet extends StatelessWidget {
  final Function onRetry;
  const SplashNoInternet({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 30),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  LocaleKeys.warnings_noInternet.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text(
                        LocaleKeys.buttons_cancel.tr(),
                        style: const TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () => onRetry.call(),
                      child: Text(
                        LocaleKeys.buttons_retry.tr(),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
