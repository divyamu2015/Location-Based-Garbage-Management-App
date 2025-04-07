import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/user_models/home_screen.dart';
import 'package:http/http.dart' as http;
import '../url_collections/uri_collection.dart';
import 'signin/page/signin_page_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.userName, required this.userId});
  final String? userName;
  final int? userId;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;
  String? data;
  int? userid;
  String? role;
  String? userName;

  // Added for password visibility toggle
  @override
  void initState() {
    super.initState();
    userName = widget.userName;
    print("For Wate Management Display=====$userName");
  }

  Future<void> getName() async {
    try {
      var response = await http.get(Uri.parse(userRegistrationUri));

      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
        });
      } else if (response.statusCode == 400) {
        showError('Bad Request: ${response.body}');
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showError('Network Error: ${e.toString()}');
    }
  }

  Future<void> login() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });

    String userInput = emailController.text.trim();
    String password = passController.text.trim();

    bool isEmail = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(userInput);
    bool isPhone = RegExp(r"^[0-9]{10}$").hasMatch(userInput);

    String url = isEmail || isPhone ? userLoginuri : employeeLogin;
    Map<String, dynamic> requestBody = {"email": userInput, "pswd": password};
    // User login

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      setState(() {
        isLoading = false;
      });

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if ((data.containsKey('message') &&
            data['message'] == "Login successful")) {
          String role = data['role'];
          int? userId = data.containsKey('userid') ? data['userid'] : null;
          String? email = data.containsKey('email') ? data['email'] : null;
          //  String? employeeId = data.containsKey('id') ? data['id'] : null;
          // print('confusion======$email');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('role', role);
          if (userId != null) await prefs.setInt('userid', userId);
          if (email != null) await prefs.setString('email', email);

          showSuccess('Login Successful! Redirecting...');
          print("For login Page======$userName");
          print('user preference userid======$userId');
          Future.delayed(const Duration(seconds: 2), () {
            if (role == 'user') {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return HomePage(userId: userId, userName: userName);
                },
              ));
            }
          });
        } else {
          showError('Invalid credentials. Try again.');
        }
      } else {
        showError("Login failed. Please try again.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showError('Network Error: ${e.toString()}');
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 0.6 * height,
                    width: width,
                    child: Image.asset(
                      'assets/images/3d-grassy-globe-with-trucks-trees-b.png',
                      height: 0.4 * height,
                      width: width,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email or Phone';
                        }
                        bool isEmail = RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value);
                        bool isPhone = RegExp(r"^[0-9]{10}$").hasMatch(value);

                        if (!isEmail && !isPhone) {
                          return 'Enter a valid Email or Phone (10-digit number)';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person_outline_outlined,
                          color: Color.fromARGB(255, 16, 82, 20),
                        ),
                        hintText: 'Email/Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passController,
                      obscureText:
                          !isPasswordVisible, // Toggle password visibility
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(255, 16, 82, 20),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: Size.fromWidth(width),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 70, 146, 72),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: login,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninPage()),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                              text: 'SignUp',
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 61, 35),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
