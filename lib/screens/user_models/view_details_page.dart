import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewdetailsHistory extends StatelessWidget {
  const ViewdetailsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<Map<String, String>> paymentHistory = [
      {
        'date': '2025-02-19',
        'time': '14:30',
        'status': 'Completed',
      },
      {
        'date': '2025-02-18',
        'time': '11:15',
        'status': 'Pending',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Payment History",
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, size: 20.sp, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: paymentHistory.length,
          itemBuilder: (context, index) {
            final payment = paymentHistory[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date: ${payment['date']}",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Time: ${payment['time']}",
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Status: ${payment['status']}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: payment['status'] == 'Completed' ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentDetailsPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          'View Details',
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer ID: 12345", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            Text("Customer Name: John Doe", style: TextStyle(fontSize: 16.sp)),
            Text("Phone No: 9876543210", style: TextStyle(fontSize: 16.sp)),
            Text("Ward: 12", style: TextStyle(fontSize: 16.sp)),
            Text("Amount: ₹500", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            Text("Payment Status: Completed", style: TextStyle(fontSize: 16.sp, color: Colors.green)),
            Text("Waste Collection Completed: Yes", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            Text("Date: 2025-02-19", style: TextStyle(fontSize: 16.sp)),
            Text("Time for Collection: 10:00 AM", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
