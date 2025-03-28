import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../../screens/user_models/view_loca_comp.dart';

class GarbageComplaintRegistration extends StatefulWidget {
  const GarbageComplaintRegistration({super.key, required this.userId});
  final int userId;
  @override
  _GarbageComplaintRegistrationState createState() =>
      _GarbageComplaintRegistrationState();
}

class _GarbageComplaintRegistrationState
    extends State<GarbageComplaintRegistration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool binChecked = false;
  double? latitude;
  double? longitude;
  DateTime selectedDate = DateTime.now();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  int? userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    print('conducion============$userId');
    }

  Future<void> fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError('Location Services disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError('Location Permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showError('Location Permission denied forever');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, distanceFilter: 10),
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> submit() async {
    if (latitude == null || longitude == null) {
      showError('Please fetch your location.');
      return;
    }

    if (_image == null) {
      showError('Please upload supporting evidence.');
      return;
    }

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate); // Format the date

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://417sptdw-8002.inc1.devtunnels.ms/userapp/complaints/"),
      );

      request.fields['name'] = nameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['bin'] = binChecked.toString();
      request.fields['place'] = placeController.text;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();
      request.fields['date'] = formattedDate;
      request.fields['user'] = userId.toString();

      // Attach image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // Make sure this field matches your API's expected image field
          _image!.path,
        ),
      );

      setState(() {
        isLoading = true; // Show loading indicator
      });

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        print("Complaint registered successfully: $responseBody");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ComplaintHistoryPage(
              userId: userId!,
            );
          },
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Complaint registered successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print("Failed to register complaint: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${response.statusCode}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      showError("Something went wrong. Please try again.");
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garbage Complaint Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Register Your Complaint',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Container(
                    //   child: CircleAvatar(
                    //     radius: 70,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Fill the field";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Fill the field";
                        }
                        if (value.length < 10 || value.length > 10) {
                          return "Required valid number";
                        }
                        return null;
                      },
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Fill the field";
                        }

                        return null;
                      },
                      controller: placeController,
                      decoration: InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: fetchLocation,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 65, 100, 84)),
                          child: const Icon(Icons.location_searching,
                              color: Colors.white),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Latitude: ${latitude?.toStringAsFixed(6) ?? '0.0'}"),
                            Text(
                                "Longitude: ${longitude?.toStringAsFixed(6) ?? '0.0'}"),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Date: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => selectDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 65, 100, 84),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Pick a Date",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: _showImageSourceDialog,
                      icon: const Icon(
                        Icons.upload_file,
                        color: Color.fromARGB(255, 44, 108, 161),
                      ),
                      label: const Text(
                        "Upload Supporting Evidence",
                        style: TextStyle(
                            color: Color.fromARGB(255, 44, 108, 161),
                            fontSize: 15),
                      ),
                    ),
                    if (_image != null) // Display the selected image
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.file(
                          _image!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // const Sizedbox(he: 15.0, wi: 0.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: binChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              binChecked = value ?? false;
                            });
                          },
                        ),
                        const Text('Request a Bin'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submit();
                        }
                        // Handle registration logic
                        // You can access the values using:
                        // nameController.text, phoneController.text, etc.
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        '   Submit Complaint  ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
