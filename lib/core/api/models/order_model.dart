class OrderModel {
  int? id;
  String? username;
  String? phone;
  String? start;
  String? destination;
  int? distance;
  double? startLat;
  double? startLon;
  double? destLat;
  double? destLon;
  String? orderType;
  String? counterStartTime;
  String? acceptedTime;
  String? endedTime;
  String? status;
  String? time;
  String? createdAt;
  String? updatedAt;
  int? driverId;
  int? userId;

  OrderModel(
      {this.id,
      this.username,
      this.phone,
      this.start,
      this.destination,
      this.distance,
      this.startLat,
      this.startLon,
      this.destLat,
      this.destLon,
      this.orderType,
      this.counterStartTime,
      this.acceptedTime,
      this.endedTime,
      this.status,
      this.time,
      this.createdAt,
      this.updatedAt,
      this.driverId,
      this.userId});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    start = json['start'];
    destination = json['destination'];
    distance = json['distance'];
    startLat = json['start_lat'];
    startLon = json['start_lon'];
    destLat = json['dest_lat'];
    destLon = json['dest_lon'];
    orderType = json['order_type'];
    counterStartTime = json['counter_start_time'];
    acceptedTime = json['accepted_time'];
    endedTime = json['ended_time'];
    status = json['status'];
    time = json['time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    driverId = json['driverId'];
    userId = json['userId'];
  }
}
