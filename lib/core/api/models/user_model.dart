class UserModel {
  int? id;
  String? username;
  String? password;
  String? phone, carModel;
  bool? isAvailable;
  bool? isOnline, isVip;
  double? lat;
  double? lng;
  double? degree;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  double? rating;

  UserModel(
      {this.id,
      this.username,
      this.password,
      this.phone,
      this.isAvailable,
      this.isOnline,
      this.isVip,
      this.carModel,
      this.lat,
      this.lng,
      this.degree,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.rating});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    isVip = json['isVip'];
    carModel = json['carModel'];
    isAvailable = json['isAvailable'];
    isOnline = json['isOnline'];
    lat = double.tryParse(json['lat'].toString());
    lng = double.tryParse(json['lng'].toString());
    degree = double.tryParse(json['degree'].toString());
    fcmToken = json['fcmToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    rating = double.tryParse(json['rating'].toString());
  }
}
