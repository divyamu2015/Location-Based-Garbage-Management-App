import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_prof_mang_bloc.dart';
import '../user_edit_pro_view/user_edit_pro_view.dart';

class EmployeeProfilePage extends StatefulWidget {
  final int userId;
  final String name;
  const EmployeeProfilePage({super.key, required this.userId, this.name = ''});

  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  int? id;

  @override
  void initState() {
    super.initState();
    id = widget.userId;
    print('After editing Page ============== $id');

    if (id != null) {
      _fetchUserProfile();
    } else {
      print("Error: userId is null in EmployeeProfilePage");
    }
  }

  void _fetchUserProfile() {
    context.read<UserProfMangBloc>().add(UserProfMangEvent.userProMan(
          id: id.toString(),
          profilePicture: '',
          name: '',
          email: '',
          place: '',
          address: '',
          phone: '',
          utype: '',
          longitude: '',
          latitude: '',
          ward: '',
        ));
  }

  // String getFullImageUrl(String? imagePath) {
  //   const String baseUrl = "https://417sptdw-8002.inc1.devtunnels.ms";
  //   if (imagePath == null || imagePath.isEmpty) {
  //     return "https://via.placeholder.com/150"; // Default placeholder image
  //   }
  //   return Uri.encodeFull(
  //       "$baseUrl/$imagePath?v=${DateTime.now().millisecondsSinceEpoch}");
  // }
  String getFullImageUrl(String? imagePath) {
    const String baseUrl = "https://417sptdw-8002.inc1.devtunnels.ms";
    if (imagePath == null || imagePath.isEmpty) {
      return "https://via.placeholder.com/150"; // Default placeholder image
    }
    return Uri.encodeFull("$baseUrl/$imagePath");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Profile")),
      body: BlocListener<UserProfMangBloc, UserProfMangState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: (user) {},
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(message, style: const TextStyle(color: Colors.red)),
                ),
              );
            },
          );
        },
        child: BlocBuilder<UserProfMangBloc, UserProfMangState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text("No Data Available")),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (userData) => Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.indigoAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            (userData.profilePicture?.isNotEmpty ?? false)
                                ? NetworkImage(
                                    getFullImageUrl(userData.profilePicture!))
                                : const AssetImage('assets/default_avatar.png')
                                    as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      userData.name, // Default value
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      userData.email, // Default value
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoRow("Phone", userData.phone),
                            buildInfoRow("Address", userData.address),
                            buildInfoRow("Place", userData.place),
                            buildInfoRow("Ward", userData.ward.toString()),
                            buildInfoRow("Longitude", userData.longitude),
                            buildInfoRow("Latitude", userData.latitude),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditEmployeeProfilePage(
                                        userId: id!,
                                      ),
                                    ),
                                  );

                                  if (result == true) {
                                    _fetchUserProfile(); // Ensure fresh data is fetched
                                    setState(() {}); // Force widget to rebuild
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Edit Profile"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              error: (message) => Center(
                child: Text(message, style: const TextStyle(color: Colors.red)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value?.isNotEmpty == true ? value! : "N/A",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
