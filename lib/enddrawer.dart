import 'package:assistant_app/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndDrawers extends StatefulWidget {
  const EndDrawers({super.key});

  @override
  State<EndDrawers> createState() => _EndDrawersState();
}

class _EndDrawersState extends State<EndDrawers> {
  Future<void> clearPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/aau_logo.png',
              width: 90,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => AboutUs(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Share This App',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () async {
              // close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'FAQs',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              // // FAQDialog()
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => FAQScreen(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () async {
              await clearPreference('token');
              await clearPreference('logged_in');
              // FAQDialog()
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Splash(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
