import 'package:flutter/material.dart';

import '../../user_authentication/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  String? userName;
  int? userId;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/wastemanage.jpeg",
      "title": "Smart Waste Management app",
      "description": "Schedule waste collection effortlessly.",
    },
    {
      "image": "assets/images/9712774_4155938.jpg",
      "title": "Track Your Requests",
      "description": "Stay updated on your submissions and payments.",
    },
    {
      "image": "assets/images/track.JPG",
      "title": "Eco-Friendly Approach",
      "description": "Encourage proper waste segregation and recycling.",
    },
    {
      "image": "assets/images/8508098_3947116.jpg",
      "title": "Booking History",
      "description": "Keep track of your past waste submissions and payments",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return LoginPage(
          userName: userName,
          userId: userId,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 241, 215, 135),
              Color.fromARGB(255, 204, 179, 104),
              Color.fromARGB(255, 236, 136, 158),
              Color.fromARGB(255, 204, 113, 133),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]["image"]!,
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: _currentPage < onboardingData.length - 1
                  ? TextButton(
                      onPressed: _goToLogin,
                      child: const Text("Skip",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: _nextPage,
                    child: Text(_currentPage == onboardingData.length - 1
                        ? "Finish"
                        : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(image, height: 250),
        ),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
