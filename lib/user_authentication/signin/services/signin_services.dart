// app_modules/register_section/service/userRegister_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../url_collections/uri_collection.dart';
import '../model/signin_model.dart';

Future<UserRegisterModel> userRegister({
 required String name,
  required String email,
  required String pswd,
  required String place,
  required String address,
  required String phone,
  required String ward,
  required double longitude,
  required double latitude,
}) async {
  try {
    final url = Uri.parse(userRegistrationUri);

    // Prepare the data as a JSON payload
    final Map<String, dynamic> body = {
     'name': name,
        'email': email,
        'pswd': pswd,  // Ensure the correct key
        'place': place,
        'address': address,
        'phone': phone,
        'ward': ward,
        'longitude': longitude,
        'latitude': latitude,
        'role': 'user',
    };

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    final Map<String, dynamic> decoded = jsonDecode(resp.body);
    print(resp.body);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final response = UserRegisterModel.fromJson(decoded);
      return response;
    } else {
      throw Exception('Failed to load response');
    }
  } on SocketException {
    throw Exception('Server error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
