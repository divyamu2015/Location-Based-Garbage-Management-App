import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../url_collections/uri_collection.dart';
import 'payment_history_page.dart';

class CardPaymentPage extends StatefulWidget {
  const CardPaymentPage({
    super.key,
    required this.totalPayment,
    required this.selectedPaymentMethod,
    this.userId,
    required this.wasteId,
  });

  final double totalPayment;
  final String selectedPaymentMethod;
  final int? userId;
  final int? wasteId;

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double totalAmount = 0.00;
  String? selectPayMethod;
  int? userid;
  int? wastesubid; // Corrected variable to store retrieved waste submission ID

  @override
  void initState() {
    super.initState();
    totalAmount = widget.totalPayment;
    selectPayMethod = widget.selectedPaymentMethod;
    userid = widget.userId;
    wastesubid = widget.wasteId;
  }

  /// ✅ Save card payment
  Future<void> saveCardPayment(BuildContext context) async {
    final url = Uri.parse(makePayment);

    if (userid == null) {
      showError('User ID is missing.');
      return;
    }

    final String paymentOption =
        (selectPayMethod == "card_payment") ? "card_payment" : "cash";

    final Map<String, dynamic> requestBody = {
      "user": userid,
      "waste_submission": wastesubid,
      "total_price": totalAmount,
      "payment_option": paymentOption,
      "name_of_card": nameController.text.trim(),
      "card_number": cardNumberController.text.trim(),
      "expiry_date": expiryDateController.text.trim(),
      "cvv": cvvController.text.trim()
    };

    print("Request Body: $requestBody");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("Response: $data");

        if (data.containsKey('message') &&
            data['message'] == 'Payment successful') {
          if (data.containsKey('waste_submission')) {
            wastesubid = data['waste_submission'];
          }

          showSuccess('Payment Successful! Redirecting...');

          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPageee(
                    userid: userid,
                  ),
                ),
              );
            }
          });
        }
      } else {
        showError('Payment failed: ${response.body}');
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
                        Image.asset('assets/images/atm-card.png', height: 60),
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
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Card Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(nameController, "Name on Card"),
                    _buildTextField(cardNumberController, "Card Number",
                        keyboardType: TextInputType.number),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              expiryDateController, "Expiry Date",
                              keyboardType: TextInputType.datetime),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(cvvController, "CVV",
                              obscureText: true,
                              keyboardType: TextInputType.number),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                    if (_formKey.currentState!.validate()) {
                      saveCardPayment(context);
                    }
                  },
                  child: const Text("Pay",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Fill the field' : null,
    );
  }
}
