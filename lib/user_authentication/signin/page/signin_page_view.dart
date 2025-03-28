import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../bloc/signin_bloc.dart';
import '../../../url_collections/uri_collection.dart';
import '../../login_page.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> wards = [];
  int? userId;
  String? selectedWardId;
  double? latitude;
  double? longitude;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getWards();
  }

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult[0]!= ConnectivityResult.none;
  }

  Future<void> _getWards() async {
    if (!await isConnected()) {
      showError('No Internet Connection');
      return;
    }
    try {
      var response = await http.get(Uri.parse(userWards));
      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            wards = List<Map<String, dynamic>>.from(data);
          });
        }
      } else {
        showError('Failed to load wards: ${response.statusCode}');
      }
    } catch (e) {
      showError('Network Error: ${e.toString()}');
    }
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

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void registerUser() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedWardId == null) {
      showError('Please select a ward.');
      return;
    }
    if (latitude == null || longitude == null) {
      showError('Please fetch your location.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    BlocProvider.of<SigninBloc>(context).add(SigninEvent.userRegister(
      name: nameController.text,
      email: emailController.text,
      pswd: passController.text,
      place: placeController.text,
      address: addressController.text,
      phone: phoneController.text,
      ward: selectedWardId!,
      longitude: double.parse(
          longitude!.toStringAsFixed(6)), // Limit to 6 decimal places
      latitude: double.parse(
          latitude!.toStringAsFixed(6)), // Limit to 6 decimal places
    ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () => setState(() => isLoading = true),
            error: (error) {
              setState(() => isLoading = false);
              showError(error);
            },
            success: (response) {
              setState(() => isLoading = false);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Registration successful!'),
                    backgroundColor: Colors.green),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(userName: nameController.text, userId: userId),
                ),
              );
            },
          );
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 18, right: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 0.4 * height,
                    width: width,
                    child: Image.asset(
                      'assets/images/3d-grassy-globe-with-trucks-trees-b.png',
                      height: 0.4 * height,
                      width: width,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField(
                            'Name',
                            Icons.person_outline_outlined,
                            nameController,
                            TextInputType.name,
                            r'^[a-zA-Z ]+$',
                            'Enter a valid Name (letters only)'),
                        const SizedBox(height: 10),
                        buildTextField('Address', Icons.info_outline_rounded,
                            addressController, TextInputType.text, null, null,
                            maxLines: 3),
                        const SizedBox(height: 10),
                        buildTextField(
                            'Phone Number',
                            Icons.phone,
                            phoneController,
                            TextInputType.number,
                            r'^\d{10}$',
                            'Invalid phone number. It should be exactly 10 digits.'),
                        const SizedBox(height: 10),
                        buildTextField('Place', Icons.place, placeController,
                            TextInputType.text, null, null),
                        const SizedBox(height: 10),
                        buildLocationButton(),
                        const SizedBox(height: 10),
                        buildWardDropdown(),
                        const SizedBox(height: 10),
                        buildTextField(
                            'Email',
                            Icons.email_outlined,
                            emailController,
                            TextInputType.emailAddress,
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            'Enter a valid Email Address'),
                        const SizedBox(height: 10),
                        buildTextField(
                            'Password',
                            Icons.lock_outline,
                            passController,
                            TextInputType.visiblePassword,
                            null,
                            null),
                        const SizedBox(height: 15),
                        buildRegisterButton(width),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label,
      IconData icon,
      TextEditingController controller,
      TextInputType type,
      String? pattern,
      String? error,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please fill the Field';
        if (pattern != null && !RegExp(pattern).hasMatch(value)) return error;
        return null;
      },
      maxLines: maxLines,
      decoration: inputDecoration(label, icon),
    );
  }

  Widget buildLocationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: fetchLocation,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Icon(Icons.location_searching, color: Colors.white),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Latitude: ${latitude?.toStringAsFixed(6) ?? '0.0'}"),
            Text("Longitude: ${longitude?.toStringAsFixed(6) ?? '0.0'}"),
          ],
        ),
      ],
    );
  }

  Widget buildWardDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedWardId,
      hint: const Text('Select Ward'),
      items: wards
          .map((ward) => DropdownMenuItem(
              value: ward['id'].toString(),
              child: Text("Ward ${ward['ward_number']}")))
          .toList(),
      onChanged: (value) => setState(() => selectedWardId = value),
      decoration: inputDecoration('Ward', Icons.select_all),
    );
  }

  Widget buildRegisterButton(double width) {
    return ElevatedButton(
      onPressed: isLoading ? null : registerUser,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, fixedSize: Size.fromWidth(width)),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('REGISTER',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white)),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: Colors.green),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
