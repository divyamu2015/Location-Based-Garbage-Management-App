import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ComplaintHistoryPage extends StatefulWidget {
  const ComplaintHistoryPage({super.key, this.userId = 0});
  final int userId;

  @override
  State<ComplaintHistoryPage> createState() => _ComplaintHistoryPageState();
}

class _ComplaintHistoryPageState extends State<ComplaintHistoryPage> {
  List<dynamic> data = [];

  int? userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    print('your userId=========$userId');
    getCompliants();
  }

  Future<void> getCompliants() async {
    final uri = Uri.parse(
        'https://417sptdw-8002.inc1.devtunnels.ms/userapp/my_complaints/$userId/');
    if (userId == null) {
      print("Error: userId is null. Cannot fetch complaints.");
      return;
    }
    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      print(uri);

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print(response);
        print(response.statusCode);
        print(response.body);
        print(data);
        setState(() {}); // Update the UI after fetching data
      } else {
        print(
            'Failed to load complaints: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching complaints: $e');
    }
  }

  String getFullImageUrl(String? imagePath) {
    const String baseUrl = "https://417sptdw-8004.inc1.devtunnels.ms";
    if (imagePath == null || imagePath.isEmpty) {
      return "";
    }
    return Uri.encodeFull("$baseUrl$imagePath");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 11, 53, 12),
            title: Text(
              "My Booking History",
              style: TextStyle(fontSize: 20.sp, color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final complaints = data[index];
              return Card(
                elevation: 8,
                margin: EdgeInsets.only(bottom: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                complaints['name'],
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Phone:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                complaints['phone'],
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Date:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                complaints['date'],
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Location:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "Latitude: ${complaints['latitude']}",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Longitude: ${complaints['longitude']}",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Bin Status:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                complaints['bin_status'].toString(),
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            // Wrap the Column with Expanded
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text properly
                              children: [
                                Text(
                                  complaints['description'],
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.black),
                                  softWrap:
                                      true, // Ensures text wraps instead of overflowing
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Proof of Work:',
                      //       style: TextStyle(
                      //           fontSize: 16.sp, fontWeight: FontWeight.bold),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     complaints['proof_of_work'] != null &&
                      //             complaints['proof_of_work']
                      //                 .toString()
                      //                 .isNotEmpty
                      //         ? Image.network(
                      //             getFullImageUrl(
                      //                 complaints['proof_of_work']),
                      //             height: 100,
                      //             width: 100,
                      //             fit: BoxFit.cover,
                      //           )
                      //         : Text(
                      //             'Not Updated',
                      //             style: TextStyle(
                      //                 fontSize: 16.sp, color: Colors.red),
                      //           ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
