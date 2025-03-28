import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditEmployeeProfilePage extends StatefulWidget {
  final int userId;
  const EditEmployeeProfilePage({super.key, required this.userId});

  @override
  State<EditEmployeeProfilePage> createState() =>
      _EditEmployeeProfilePageState();
}

class _EditEmployeeProfilePageState extends State<EditEmployeeProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool isUpdating = false;
  int? id;
  String? _profilePictureUrl;
  File? _imageFile;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = widget.userId;
    _fetchUserData();
  }

  /// Fetch user profile data from the API
  Future<void> _fetchUserData() async {
    final url =
        "https://417sptdw-8002.inc1.devtunnels.ms/userapp/profile/update/$id/";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _nameController.text = data['name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _addressController.text = data['address'] ?? '';
          _placeController.text = data['place'] ?? '';
          _wardController.text = data['ward']?.toString() ?? '';
          _longitudeController.text = data['longitude'] ?? '';
          _latitudeController.text = data['latitude'] ?? '';
          _profilePictureUrl = data['profile_picture_url'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load user data");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar("Error fetching data: $e");
    }
  }

  /// Select an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// Upload selected image
  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      _showSnackBar("Please select an image first.");
      return;
    }

    final url =
        "https://417sptdw-8002.inc1.devtunnels.ms/userapp/profile/update/$id/";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['id'] = id.toString();
    request.files.add(
        await http.MultipartFile.fromPath("profile_picture", _imageFile!.path));
    request.headers.addAll({"Content-Type": "multipart/form-data"});

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        _showSnackBar("Profile picture updated successfully");
        _fetchUserData(); // Refresh the profile picture
      } else {
        throw Exception("Failed to upload image");
      }
    } catch (e) {
      _showSnackBar("Error uploading image: $e");
    }
  }

  /// Show snackbar messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Returns full image URL
  String getFullImageUrl(String? imagePath) {
    const String baseUrl = "https://417sptdw-8002.inc1.devtunnels.ms";
    if (imagePath == null || imagePath.isEmpty) {
      return "https://via.placeholder.com/150"; // Default placeholder image
    }
    return Uri.encodeFull("$baseUrl/$imagePath");
  }

  /// Save updated details
  Future<void> _saveDetails() async {
    final String url =
        'https://417sptdw-8002.inc1.devtunnels.ms/userapp/profile/update/$id/';
    var request = http.MultipartRequest('PUT', Uri.parse(url));

    request.fields['id'] = id.toString();
    request.fields['name'] = _nameController.text.trim();
    request.fields['email'] = _emailController.text.trim();
    request.fields['place'] = _placeController.text;
    request.fields['address'] = _addressController.text;
    request.fields['phone'] = _phoneController.text.trim();
    request.fields['longitude'] = _longitudeController.text;
    request.fields['latitude'] = _latitudeController.text;
    request.fields['ward'] = _wardController.text;

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', _imageFile!.path));
    }

    request.headers.addAll({"Content-Type": "multipart/form-data"});

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        showSuccess('Profile updated successfully');
        Navigator.pop(context, true);
      } else {
        showError('Update failed: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      showError('Error: $e');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!) as ImageProvider
                                : NetworkImage(
                                    getFullImageUrl(_profilePictureUrl)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.blue),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField("Name", _nameController),
                    _buildTextField("Email", _emailController),
                    _buildTextField("Phone", _phoneController),
                    _buildTextField("Address", _addressController),
                    _buildTextField("Place", _placeController),
                    _buildTextField("Ward", _wardController, isNumeric: true),
                    _buildTextField("Longitude", _longitudeController),
                    _buildTextField("Latitude", _latitudeController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveDetails();
                          // Navigator.pop(context);
                        }
                      },
                      child: const Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

/// Custom text field widget
Widget _buildTextField(String label, TextEditingController controller,
    {bool isNumeric = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "$label cannot be empty" : null,
    ),
  );
}
