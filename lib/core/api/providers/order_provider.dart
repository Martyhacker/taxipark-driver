import 'package:flutter/material.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/api/services/order_service.dart';
import 'package:taxipark_driver/core/constants/constants.dart';

class OrderProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  OrderModel? _order;
  OrderModel? get order => _order;
  final List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;
  int _count = 0;
  int get count => _count;

  int _offset = 0;
  final int _limit = kLimit;
  Map<String, String> _query = {};
  set query(Map<String, String> q) {
    _query = q;
    notifyListeners();
  }

  _addAllOrders(value) {
    _orders.addAll(value);
    _offset += _limit;
    notifyListeners();
  }

  reset() {
    _query.clear();
    _orders.clear();
    _count = 0;
    _offset = 0;
  }

  fetchOneOrder({required int id, Function? onSuccess, Function? onError}) {
    return OrderService().getOneOrder(id: id).then((value) {
      _order = value;
      onSuccess?.call();
      notifyListeners();
    }).catchError((err) {
      onError?.call();
      debugPrint("Get one order error: $err");
    });
  }

  fetchOrders({Function? onSuccess}) {
    if (_isFetching) return;
    _isFetching = true;
    return OrderService()
        .getOrders(limit: _limit, offset: _offset, query: _query)
        .then((value) {
      if (value['data'].isNotEmpty) {
        _addAllOrders(value['data']);
        _count = value['count'];
      }
      onSuccess?.call();
      _isFetching = false;
      notifyListeners();
    }).catchError((err) {
      debugPrint("Get orders error: $err");
      _isFetching = false;
      notifyListeners();
    });
  }

  changeOrder(
      {required int id,
      required Map<String, dynamic> body,
      Function? onSuccess,
      Function? onError}) {
    return OrderService().changeOrder(id: id, body: body).then((value) {
      _order = value;
      onSuccess?.call();
    }).catchError((err) {
      onError?.call();
      debugPrint("Change order error: $err");
    });
  }

  changeStatus(
      {required int id,
      required String status,
      Function? onSuccess,
      Function? onError,
      Function? onTaken}) {
    return OrderService()
        .changeStatus(id: id, status: status.toUpperCase())
        .then((value) {
      switch (value) {
        case 200:
          onSuccess?.call();
          break;
        case 403:
          onTaken?.call();
          break;
        default:
          onError?.call();
          break;
      }
    }).catchError((err) {
      onError?.call();
      debugPrint("Change order status error: $err");
    });
  }
}
