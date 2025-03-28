import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../url_collections/uri_collection.dart';
import 'payment_history_page.dart';

class CashPaymentPage extends StatefulWidget {
  const CashPaymentPage(
      {super.key,
      // required this.totalPayment,
      required this.selectedPaymentMethod,
      this.userId,
      required this.wasteId});
  // final double totalPayment;
  final String selectedPaymentMethod;
  final int? userId;
  final int? wasteId;
  //final List<Map<String, String>> banks;

  @override
  State<CashPaymentPage> createState() => _CashPaymentPageState();
}

class _CashPaymentPageState extends State<CashPaymentPage> {
  double totalAmount = 0.00;
  String? selectPayMethod;
  int? userId;
  int? waste_subid;
  @override
  void initState() {
    // TODO: implement initState
    //totalAmount = widget.totalPayment;
    selectPayMethod = widget.selectedPaymentMethod;
    userId = widget.userId;
    waste_subid = widget.wasteId;
    super.initState();
    print(selectPayMethod);
  }

  //Futu
  void showPaymentFailedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Request for Payment"),
        content: const Text(
            "User has not paid the amount. Would you like to proceed with Pay on Request?"),
        actions: [
          TextButton(
            onPressed: () {
              saveCashPayment();
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPageee(userid: userId),
                    ),
                  );
                }
              });
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  Future<void> saveCashPayment() async {
    if (userId == null) {
      showError('User ID is missing.');
      return;
    }

    final String paymentOption =
        (selectPayMethod == "cash") ? "cash" : "card_payment";
    final Map<String, dynamic> requestBody = {
      "user": userId,
      "waste_submission": waste_subid,
      "payment_option": paymentOption,
      "total_price":
          totalAmount.toString() // Convert to string if API expects it
    };

    print(' Request Body: $requestBody');

    try {
      final response = await http.post(
        Uri.parse(makePayment),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(requestBody),
      );

      print(' Response Code: ${response.statusCode}');
      print(' Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data.containsKey('message') &&
            data['message'] == "Payment successful") {
          if (data.containsKey('waste_submission')) {
            waste_subid = data['waste_submission'];
            showSuccess("Payment Successful! Redirecting...");
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryPageee(
                          userid: userId,
                        )),
              );
            });
          }
        } else {
          showError('Payment failed: ${data['message']}');
        }
      } else {
        showError('Payment failed: ${response.body}');
      }
    } catch (e) {
      showError('Error: $e');
    }
  }

  void showError(String message) {
    if (!mounted) {
      return; // Prevents calling setState or accessing context if unmounted
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    if (!mounted) return; // Ensures widget is still part of the tree
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('Pay Invoice', style: TextStyle(color: Colors.white)),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/payment.png', height: 60),
                        const SizedBox(height: 10),
                        const Text("Payment Amount",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(
                          '₹$totalAmount',
                          style: TextStyle(
                              fontSize: 70.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        // const Text("₹ XXXX.XX",
                        //     style: TextStyle(
                        //         fontSize: 22,
                        //         color: Colors.green,
                        //         fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              SizedBox(
                width: width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    showPaymentFailedDialog();
                    //saveCashPayment();

                    // Handle payment processing
                  },
                  child: const Text("Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
