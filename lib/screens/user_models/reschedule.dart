import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ReschedulePage extends StatefulWidget {
  final int wasteId;
  final int userId;
  final String wasteName;
  final double amount;

  const ReschedulePage(
      {super.key,
      required this.wasteId,
      required this.userId,
      required this.wasteName,
      required this.amount});

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

class _ReschedulePageState extends State<ReschedulePage> {
  int? id;
  double? amount;
  String? wasteName;
  List<Map<String, dynamic>> paymentHistory = [];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedWaste = "Plastic"; // Example selected waste
  double totalPrice = 100.0; // Example price
  int? userId;

  @override
  void initState() {
    super.initState();
    id = widget.wasteId;
    amount = widget.amount;
    wasteName = widget.wasteName;
    userId = widget.userId;
  }

  Future<void> rescheduleDetails() async {
    try {
      final String apiUrl =
          'https://417sptdw-8002.inc1.devtunnels.ms/userapp/reschedule/$id/';

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "date": DateFormat('dd-MM-yyyy').format(selectedDate),
          "time": "${selectedTime.hour}:${selectedTime.minute}:00",
          // "status": "pending",
          "categories": wasteName, // Sending waste names as a single string
          "total_price": amount.toString(), // Ensure it's a string
          "kilo": null,
          "description": null,
          "user": userId, // Assuming user ID is 2, update dynamically if needed
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess('Pickup successfully rescheduled!');
        Navigator.pop(context, true);
      } else {
        showError("Failed to reschedule. Try again later.");
      }
    } catch (e) {
      showError("An error occurred. Please try again.");
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

  /// Function to select a date using a calendar
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  /// Function to select a time
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  /// Function to handle rescheduling
  void reschedulePickup() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pickup rescheduled to ${DateFormat('yyyy-MM-dd').format(selectedDate)} at ${selectedTime.format(context)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 53, 12),
        title: Text(
          "Reschedule PickUp",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, size: 20.sp, color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Selected Waste:",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 5.h),
                Text(
                  wasteName?.split(', ').join('\n') ?? '',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Total Amount: $amount",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                        backgroundColor: const Color.fromARGB(255, 65, 100, 84),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("Pick a Date",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
                        backgroundColor: const Color.fromARGB(255, 65, 100, 84),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("Pick a Time",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      rescheduleDetails();
                    },
                    label: const Text(
                      'Reschedule',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                          ),
                    ),
                    icon: const Icon(Icons.replay_outlined),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
