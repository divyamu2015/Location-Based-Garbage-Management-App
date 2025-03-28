import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../url_collections/uri_collection.dart';

class ProfileManagementPage extends StatefulWidget {
  const ProfileManagementPage(
      {super.key, required this.userId, required this.name});
  final int userId;
  final String name;

  @override
  State<ProfileManagementPage> createState() => _ProfileManagementPageState();
}

class _ProfileManagementPageState extends State<ProfileManagementPage> {
  int? id;
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    id = widget.userId;
    userName = widget.name;
    getUserProfileDet();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController wardController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> getUserProfileDet() async {
    final response = await http.get(Uri.parse(profileManagement));
    print('Profile Management response===== $response');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      print('Profile Management response===== $data');
    }
  }

  // void _saveProfile() async {
  //   if (_formKey.currentState!.validate()) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('name', nameController.text);
  //     await prefs.setString('email', emailController.text);
  //     await prefs.setString('password', passwordController.text);
  //     await prefs.setString('place', placeController.text);
  //     await prefs.setString('address', addressController.text);
  //     await prefs.setString('phone', phoneController.text);
  //     await prefs.setString('longitude', longitudeController.text);
  //     await prefs.setString('latitude', latitudeController.text);
  //     await prefs.setString('ward', wardController.text);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Profile Updated Successfully')),
  //     );
  //   }
  // }

  // void _deleteProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Profile Deleted')),
  //   );
  //   setState(() {
  //     nameController.clear();
  //     emailController.clear();
  //     passwordController.clear();
  //     placeController.clear();
  //     addressController.clear();
  //     phoneController.clear();
  //     longitudeController.clear();
  //     latitudeController.clear();
  //     wardController.clear();
  //     _image = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile Management'),
          backgroundColor: Colors.green[700]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField('Name', nameController),
                _buildTextField('Email', emailController),
                _buildTextField('Password', passwordController,
                    obscureText: true),
                _buildTextField('Place', placeController),
                _buildTextField('Address', addressController),
                _buildTextField('Phone', phoneController),
                _buildTextField('Longitude', longitudeController),
                _buildTextField('Latitude', latitudeController),
                _buildTextField('Ward', wardController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text('Delete')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
