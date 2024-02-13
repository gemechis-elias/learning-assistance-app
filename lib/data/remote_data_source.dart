import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApiDataSource {
  final String baseUrl;
  UserApiDataSource({required this.baseUrl});

  @override
  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> loginData) async {
    final url = Uri.parse('$baseUrl/auth/signin');
    print("==========> Request sent! $baseUrl/auth/signin");
    print("==========> Data: $loginData");

    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      print("==========> User successfully logged in <==========");
      print("User data: $userData");

      await saveUserInfo(userData);

      return userData;
    } else {
      print("==========> User failed to login:${response.body} <==========");
      throw Exception('Something went wrong!${response.body}');
    }
  }

  Future<void> saveUserInfo(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', userData['token']);
    // prefs.setString('userId', userData['user']['id']);
    print("==========> Token Saved! <==========");
  }

  @override
  Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/auth/signup');
    print("==========> Request sent! $baseUrl/auth/signup");
    print("==========> Data: $userData");

    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      print("==========> User successfully Registered <==========");
      print("User data: $userData");

      await saveUserInfo(userData);

      return userData;
    } else {
      print("==========> User failed to login:${response.body} <==========");
      throw Exception('Something went wrong!${response.body}');
    }
  }
}
