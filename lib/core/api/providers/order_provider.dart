import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/api/services/order_service.dart';
import 'package:taxipark_driver/core/constants/constants.dart';

class OrderProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  final List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;
  int _count = 0;
  int get count => _count;

  int _offset = 0;
  final int _limit = kLimit;
  _addAllOrders(value) {
    _orders.addAll(value);
    _offset += _limit;
    notifyListeners();
  }

  reset() {
    _orders.clear();
    _offset = 0;
  }

  fetchOrders() {
    if (_isFetching) return;
    _isFetching = true;
    return OrderService()
        .getOrders(limit: _limit, offset: _offset)
        .then((value) {
      if (value['data'].isNotEmpty) {
        _addAllOrders(value['data']);
        _count = value['count'];
      }
      _isFetching = false;
      notifyListeners();
    }).catchError((err) {
      debugPrint("Get orders error: $err");
      _isFetching = false;
      notifyListeners();
    });
  }
}
