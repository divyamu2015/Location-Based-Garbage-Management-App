// To parse this JSON data, do
//
//     final complaintRegisterModel = complaintRegisterModelFromJson(jsonString);

import 'dart:convert';

List<ComplaintRegisterModel> complaintRegisterModelFromJson(String str) => List<ComplaintRegisterModel>.from(json.decode(str).map((x) => ComplaintRegisterModel.fromJson(x)));

String complaintRegisterModelToJson(List<ComplaintRegisterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintRegisterModel {
    int id;
    String name;
    String phone;
    String description;
    String image;
    bool bin;
    String status;
    String binStatus;
    String place;
    dynamic latitude;
    dynamic longitude;
    DateTime date;
    int user;
    dynamic driver;

    ComplaintRegisterModel({
        required this.id,
        required this.name,
        required this.phone,
        required this.description,
        required this.image,
        required this.bin,
        required this.status,
        required this.binStatus,
        required this.place,
        required this.latitude,
        required this.longitude,
        required this.date,
        required this.user,
        required this.driver,
    });

    factory ComplaintRegisterModel.fromJson(Map<String, dynamic> json) => ComplaintRegisterModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        description: json["description"],
        image: json["image"],
        bin: json["bin"],
        status: json["status"],
        binStatus: json["bin_status"],
        place: json["place"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        date: DateTime.parse(json["date"]),
        user: json["user"],
        driver: json["driver"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "description": description,
        "image": image,
        "bin": bin,
        "status": status,
        "bin_status": binStatus,
        "place": place,
        "latitude": latitude,
        "longitude": longitude,
        "date": date.toIso8601String(),
        "user": user,
        "driver": driver,
    };
}
