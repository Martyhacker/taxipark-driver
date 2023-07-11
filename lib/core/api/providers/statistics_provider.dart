import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/api/models/statistics_model.dart';
import 'package:taxipark_driver/core/api/services/statistics_service.dart';

class StatisticsProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  StatisticsModel? _model;
  StatisticsModel? get model => _model;

  getStatistics({Function? onError, Function? onSuccess}) {
    if (_isFetching) return;
    _isFetching = true;
    return StatisticsService().getStatistics().then((value) {
      _model = value;
      _isFetching = false;
      notifyListeners();
    }).catchError((err) {
      _isFetching = false;
      debugPrint("Statistics get error: $err");
      notifyListeners();
    });
  }
}
