import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Нет подключения к Интернету, попробуйте еще раз.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: const Text(
                        'Отмена',
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () => onRetry.call(),
                      child: const Text('Попробовать')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
