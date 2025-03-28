// To parse this JSON data, do
//
//     final userProfManageModel = userProfManageModelFromJson(jsonString);

import 'dart:convert';

UserProfManageModel userProfManageModelFromJson(String str) => UserProfManageModel.fromJson(json.decode(str));

String userProfManageModelToJson(UserProfManageModel data) => json.encode(data.toJson());

class UserProfManageModel {
    int id;
    dynamic profilePicture;
    String name;
    String email;
    String place;
    String address;
    String phone;
    String utype;
    String longitude;
    String latitude;
    int ward;

    UserProfManageModel({
        required this.id,
        required this.profilePicture,
        required this.name,
        required this.email,
        required this.place,
        required this.address,
        required this.phone,
        required this.utype,
        required this.longitude,
        required this.latitude,
        required this.ward,
    });

    factory UserProfManageModel.fromJson(Map<String, dynamic> json) => UserProfManageModel(
        id: json["id"],
        profilePicture: json["profile_picture"],
        name: json["name"],
        email: json["email"],
        place: json["place"],
        address: json["address"],
        phone: json["phone"],
        utype: json["utype"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        ward: json["ward"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profile_picture": profilePicture,
        "name": name,
        "email": email,
        "place": place,
        "address": address,
        "phone": phone,
        "utype": utype,
        "longitude": longitude,
        "latitude": latitude,
        "ward": ward,
    };
}
