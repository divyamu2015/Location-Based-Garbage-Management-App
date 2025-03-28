import 'package:flutter/material.dart';
import '../../user_authentication/login_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final String email;

  HomePage({super.key, required this.email, required this.userId});
  int? userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? userId;
  String? employeeId;

  @override
  void initState() {
    // TODO: implement initState
    userId = widget.userId;
    super.initState();
    print('Home Screen ==============$userId');
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> homeList = [
      {'name': 'Plastic', 'kg': '10 kg'},
      {'name': 'Non-Biodegradable Wastes', 'kg': '10 kg'},
      {'name': 'Hazardous Waste', 'kg': '10 kg'},
      {'name': 'E-Waste', 'kg': '10 kg'},
      {'name': 'Sanitary Waste', 'kg': '10 kg'},
      {'name': 'Other Waste', 'kg': '10 kg'},
    ];

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 53, 119, 87),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.account_circle,
                        size: 60, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      widget.email,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile Management'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('View History'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Feed Back'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Do you want to Logout?',
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return LoginPage(
                                        userName: employeeId,
                                        userId: userId,
                                      );
                                    },
                                  ));
                                },
                                child: const Text('Yes'),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 53, 119, 87),
          title: const Text(
            'Waste Management',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {},
              label: const Text(
                'Current Location',
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Collected Waste Given by ME....',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: homeList.length,
                  itemBuilder: (context, index) {
                    final list = homeList[index];
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.clean_hands_outlined,
                                size: 40, color: Colors.green),
                            const SizedBox(height: 8),
                            Text(
                              list['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              list['kg'],
                              style: const TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 53, 119, 87),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Request',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
