// To parse this JSON data, do
//
//     final employeeLoginPage = employeeLoginPageFromJson(jsonString);

import 'dart:convert';

UserRegisterModel userRegisterModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userRegisterModelToJson(UserRegisterModel data) =>
    json.encode(data.toJson());

class UserRegisterModel {
  String message;
  String role;
  String name;
  String email;
  String place;
  String address;
  String phone;
  int ward; //
  String profilePicture;
  double longitude;
  double latitude;

  UserRegisterModel({
    required this.message,
    required this.role,
    required this.name,
    required this.email,
    required this.place,
    required this.address,
    required this.phone,
    required this.ward,
    required this.profilePicture,
    required this.longitude,
    required this.latitude,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
        message: json["message"] ?? '',
        role: json["role"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        place: json["place"] ?? '',
        address: json["address"] ?? '',
        phone: json["phone"] ?? '',
        ward: json["ward"] ?? 0, // Default to 0 if null
        profilePicture:
            json["profile_picture"]?.toString() ?? '', // Handle null
        longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
        latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "role": role,
        "name": name,
        "email": email,
        "place": place,
        "address": address,
        "phone": phone,
        "ward": ward,
        "profile_picture": profilePicture,
        "longitude": longitude,
        "latitude": latitude,
      };
}
