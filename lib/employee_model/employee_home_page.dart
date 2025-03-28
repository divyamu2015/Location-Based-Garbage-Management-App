import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePagess extends StatefulWidget {
  const HomePagess({
    super.key,
  });

  @override
  State<HomePagess> createState() => _HomePagessState();
}

class _HomePagessState extends State<HomePagess> {
  final int _selectedIndex = 0;

  _onItemTapped(int index) {
    if (index == 1) {
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return HistoryPage(
      //       userid: userId,
      //     );
      //   },
      // ));
    }
    if (index == 2) {
      showAlertBox();
    }
  }

  void showAlertBox() {
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
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return LoginPage(
                    //       userName: userName,
                    //     );
                    //   },
                    // ));
                  },
                  child: const Text('Yes'),
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 53, 119, 87),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle, size: 60, color: Colors.white),
                    SizedBox(height: 10),
                    // Text(
                    //   widget.email,
                    //   style: const TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile Management'),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const ProfileManagementPage();
                  //   },
                  // ));
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.history),
              //   title: const Text('View History'),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(
              //       builder: (context) {
              //         return  HistoryPage(userId:userId ,);
              //       },
              //     ));
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Feed Back'),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const FeedbackPage();
                  //   },
                  // ));
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.feedback_outlined),
              //   title: const Text('Graph History'),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(
              //       builder: (context) {
              //         return const GraphHistoryScreen();
              //       },
              //     ));
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  showAlertBox();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 53, 119, 87),
          // title: Text(
          //   userName!,
          //   style: const TextStyle(color: Colors.white, fontSize: 18),
          // ),
          // actions: [
          //   TextButton.icon(
          //     onPressed: () {},
          //     label: const Text(
          //       'Current Location',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     icon: const Icon(
          //       Icons.location_on_outlined,
          //       color: Colors.white,
          //     ),
          //   )
          // ],
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
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 10,
              //       crossAxisSpacing: 10,
              //     ),
              //     itemCount: homeList.length,
              //     itemBuilder: (context, index) {
              //       final list = homeList[index];
              //       return Card(
              //         color: Colors.white,
              //         elevation: 4,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               const Icon(Icons.clean_hands_outlined,
              //                   size: 40, color: Colors.green),
              //               const SizedBox(height: 8),
              //               Text(
              //                 list['name'],
              //                 style: const TextStyle(
              //                     fontWeight: FontWeight.bold, fontSize: 16),
              //                 textAlign: TextAlign.center,
              //               ),
              //               const SizedBox(height: 4),
              //               Text(
              //                 list['kg'],
              //                 style: const TextStyle(color: Colors.grey),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
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
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return const WasteSubmitPage();
                    //   },
                    // ));
                  },
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
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color.fromARGB(255, 24, 87, 27),
            selectedFontSize: 14.0,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12.0,
            //  selectedIconTheme: IconThemeData(),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'View History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.logout_sharp), label: 'Logout')
            ]),
      ),
    );
  }
}
