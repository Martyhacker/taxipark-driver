import 'package:flutter/material.dart';

class LanguageManager{
  LanguageManager._init();
  static LanguageManager? _instance;
  static LanguageManager? get instance{
    _instance ??= LanguageManager._init();
    return _instance;
  }
  final tmLocale = const Locale('tr','TR');
  final ruLocale = const Locale('ru','RU');
  List<Locale> get supportedLocales => [tmLocale, ruLocale];
} 