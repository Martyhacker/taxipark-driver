class UserModel {
  int? id;
  String? username;
  String? password;
  String? phone;
  String? address;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.username,
      this.password,
      this.phone,
      this.address,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    fcmToken = json['fcmToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}