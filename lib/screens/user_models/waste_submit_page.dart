import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../url_collections/uri_collection.dart';
import 'payment.dart';

class WasteSubmitPage extends StatefulWidget {
  const WasteSubmitPage({super.key});

  @override
  State<WasteSubmitPage> createState() => _WasteSubmitPageState();
}

class _WasteSubmitPageState extends State<WasteSubmitPage> {
  int? userId;
  int? wasteId;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<dynamic> categories = [];
  bool isLoading = true;
  // Map: key -> category id, value -> entered kilogram string
  Map<int, String> selectedCategories = {};
  double totalPrice = 50.0;

  @override
  void initState() {
    super.initState();
    getUserId(); // Fetch userId before loading categories
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedUserId = prefs.getInt('userid');

    if (storedUserId != null && storedUserId > 0) {
      setState(() {
        userId = storedUserId;
      });
      viewCategory();
    } else {
      showError("User ID not found. Please log in again.");
    }
  }

  Future<void> viewCategory() async {
    try {
      final response = await http.get(Uri.parse(wasteCategoryUri));

      if (response.statusCode == 200) {
        setState(() {
          categories = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        showError('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => isLoading = false);
      showError('Network Error: ${e.toString()}');
    }
  }

  // void calculateTotalPrice() {
  //   double sum = 0.0;
  //   for (var categoryId in selectedCategories.keys) {
  //     var category = categories.firstWhere((cat) => cat['id'] == categoryId,
  //         orElse: () => {});
  //     double categoryPrice = category.isNotEmpty
  //         ? double.tryParse(category['price'].toString()) ?? 0.0
  //         : 0.0;
  //     sum += categoryPrice; // Add only the category price
  //   }
  //   // Loop through each selected category and calculate price * kilogram

  //   setState(() {
  //     totalPrice = sum;
  //   });
  // }

  Future<void> saveCollection() async {
    if (selectedCategories.isEmpty) {
      showError("Please select at least one category and enter its weight.");
      return;
    }

    List<String> selectedCategoryNames = [];
    for (var categoryId in selectedCategories.keys) {
      final category = categories.firstWhere(
        (cat) => cat['id'] == categoryId,
        orElse: () => null,
      );
      if (category != null) {
        selectedCategoryNames.add(category['name']);
      }
    }

    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    String formattedTime = DateFormat("HH:mm:ss")
        .format(DateTime(2020, 1, 1, selectedTime.hour, selectedTime.minute));

    Map<String, dynamic> requestBody = {
      "user": userId,
      "date": formattedDate,
      "time": formattedTime,
      "status": "pending",
      "categories": selectedCategoryNames.join(","),
      "total_price": totalPrice
    };

    try {
      var response = await http.post(
        Uri.parse(wasteSubmissionurl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        wasteId = responseData['id'];

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Submitted Successfully'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentOpp(
                        totalPayment: totalPrice,
                        userId: userId!,
                        wasteSubId: wasteId!,
                      ),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showError("Error submitting: ${response.body}");
      }
    } catch (e) {
      showError('Network Error: ${e.toString()}');
    }
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

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2D6A4F),
          title: const Text('Waste Submission',
              style: TextStyle(color: Colors.white)),
          elevation: 4,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : categories.isEmpty
                ? const Center(child: Text('No Data Found'))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final int categoryId = category['id'];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Row(
                                    children: [
                                      // Image Container
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: category['image'] != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  "$baseUrl${category['image']}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(Icons.error,
                                                          color: Colors.red),
                                                ),
                                              )
                                            : const Icon(
                                                Icons.image_not_supported),
                                      ),
                                      const SizedBox(width: 10),

                                      // Expanded Name
                                      Expanded(
                                        child: Text(
                                          category['name'],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      // Checkbox
                                      Checkbox(
                                        value: selectedCategories
                                            .containsKey(categoryId),
                                        onChanged: (bool? isChecked) {
                                          setState(() {
                                            if (isChecked == true) {
                                              selectedCategories.putIfAbsent(
                                                  categoryId, () => '');
                                            } else {
                                              selectedCategories
                                                  .remove(categoryId);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Price:',
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    width: 180, // Adjust width as needed
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      initialValue: totalPrice.toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          totalPrice =
                                              double.tryParse(value) ?? 0.0;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Text(
                                    "Selected Date: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => selectDate(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 65, 100, 84),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: const Text("Pick a Date",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    "Selected Time: ${selectedTime.format(context)}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 25),
                                  ElevatedButton(
                                    onPressed: () => selectTime(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 65, 100, 84),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: const Text("Pick a Time",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 20),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         children: [
                        //           const Text('Total Price: ',
                        //               style: TextStyle(fontSize: 16)),
                        //           const SizedBox(width: 10),
                        //           Text(
                        //             totalPrice.toStringAsFixed(
                        //                 2), // ✅ Fixes the type conversion issue
                        //             style: const TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ],
                        //       ),
                        //       const SizedBox(height: 20),
                        //     ],
                        //   ),
                        // ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 65, 100, 84),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: saveCollection,
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: const Text('Continue',
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
