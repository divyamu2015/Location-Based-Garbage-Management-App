import 'dart:convert';
import 'dart:io';
import '../user_prof_mang_model/emplo_prof_model.dart';
import 'package:http/http.dart' as http;

Future<UserProfManageModel> userProMan({
  required String id,
  required String profilePicture,
  required String name,
  required String email,
  required String place,
  required String address,
  required String phone,
  required String utype,
  required String longitude,
  required String latitude,
  required String ward,
}) async {
  try {
    final String url =
        'https://417sptdw-8002.inc1.devtunnels.ms/userapp/profile/$id/';

    final res = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(res.body);
      final response = UserProfManageModel.fromJson(decoded);
      return response;
    } else {
      throw Exception('Failed to load response ${res.statusCode}');
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

Future<UserProfManageModel> edituserProMan({
  required String id,
  required String profilePicture,
  required String name,
  required String email,
  required String place,
  required String address,
  required String phone,
  required String utype,
  required String longitude,
  required String latitude,
  required String ward,
}) async {
  try {
    final String url =
        'https://417sptdw-8002.inc1.devtunnels.ms/userapp/profile/$id/';

    final res = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(res.body);
      final response = UserProfManageModel.fromJson(decoded);
      return response;
    } else {
      throw Exception('Failed to load response ${res.statusCode}');
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
