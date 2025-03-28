import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../url_collections/uri_collection.dart';
import '../complaint_model/complaint_model.dart';

Future<ComplaintRegisterModel> complreg({
  required String name,
  required String phone,
  required dynamic latitude,
  required dynamic longitude,
  required String description,
  required File image, // Change to File type
  required bool bin,
  required String place,
  required String date,
  required int user,
}) async {
  try {
    final uri = locationbased;
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['description'] = description;
    request.fields['bin'] = bin.toString();
    request.fields['place'] = place;
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.fields['date'] = date;
    request.fields['user'] = user.toString();

    // Add the image file
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
  
    final res = await request.send();
    final responseString = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(responseString);
      final response = ComplaintRegisterModel.fromJson(decoded);
      return response;
    } else {
      throw Exception(
          'Failed to load response: ${res.statusCode} - $responseString');
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
