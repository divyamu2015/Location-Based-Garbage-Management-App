import 'dart:convert';
import 'dart:io';

import '../user_payment_model/user_payment_model.dart';
import 'package:http/http.dart' as http;

Future<UserPymentHistoryModel> userpayhistory({
  required int id,
  required String paymentOption,
  required String status,
  required String totalPrice,
  required String cashStatus,
  required dynamic transactionId,
  required dynamic nameOfCard,
  required dynamic cardNumber,
  required dynamic expiryDate,
  required dynamic cvv,
  required int user,
  required int wasteSubmission,
}) async {
  try {
    const String url =
        'https://417sptdw-8002.inc1.devtunnels.ms/userapp/user/2/payments/';

    final res = await http.get(Uri.parse(url));
    print(res);
    print(res.body);
    if (res.statusCode == 200) {
      print(res.statusCode);
      final Map<String, dynamic> decoded = jsonDecode(res.body);
      final response = UserPymentHistoryModel.fromJson(decoded);
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
