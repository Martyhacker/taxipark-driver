class StatisticsModel {
  double? profit;
  Orders? orders;

  StatisticsModel({this.profit, this.orders});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    profit = double.tryParse(json['profit'].toString());
    orders = json['orders'] != null ? Orders.fromJson(json['orders']) : null;
  }
}

class Orders {
  int? allOrders;
  int? completedOrders;
  int? waitingOrders;

  Orders({this.allOrders, this.completedOrders, this.waitingOrders});

  Orders.fromJson(Map<String, dynamic> json) {
    allOrders = json['allOrders'];
    completedOrders = json['completedOrders'];
    waitingOrders = json['waitingOrders'];
  }
}
