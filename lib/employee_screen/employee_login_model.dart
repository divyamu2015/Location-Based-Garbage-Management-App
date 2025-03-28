// To parse this JSON data, do
//
//     final employeeLoginPage = employeeLoginPageFromJson(jsonString);

import 'dart:convert';

EmployeeLoginPage employeeLoginPageFromJson(String str) => EmployeeLoginPage.fromJson(json.decode(str));

String employeeLoginPageToJson(EmployeeLoginPage data) => json.encode(data.toJson());

class EmployeeLoginPage {
    String detail;
    String role;
    String id;

    EmployeeLoginPage({
        required this.detail,
        required this.role,
        required this.id,
    });

    factory EmployeeLoginPage.fromJson(Map<String, dynamic> json) => EmployeeLoginPage(
        detail: json["detail"],
        role: json["role"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
        "role": role,
        "id": id,
    };
}
