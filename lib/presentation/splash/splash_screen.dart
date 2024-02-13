import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';
import '../teachers/dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkFirstVisit();
  }

  Future<void> checkFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    final visitedBefore = prefs.getBool('logged_in') ?? false;

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (visitedBefore) {
          // If visited before, navigate to Home()
          Navigator.pushReplacement(
            context,
            // MaterialPageRoute(builder: (context) => const Dashboard()),
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          // If first visit, navigate to OnBoardingScreen()
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );

          // Set visited_before flag to true for future visits
          prefs.setBool('logged_in', true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // status bar icon to white

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset('assets/images/aau_logo.png'),
                ),
                const Text(
                  'Learning Assistant App',
                  style: TextStyle(
                    fontSize: 19,
                    color: Color.fromARGB(171, 86, 82, 77),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Version 1.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(182, 94, 93, 93),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
