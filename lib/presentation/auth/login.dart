// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/remote_data_source.dart';
import '../teachers/dashboard.dart';
import 'signup.dart';
// import '../../../education_squad/presentation/dashboard/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/aau_logo.png',
                  width: 90,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTextField('Email', Icons.email),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Implement forgot password functionality
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffA57D1E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: () async {
                      if (_validateInputs()) {
                        // Show loading indicator
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          final userApiDataSource = UserApiDataSource(
                              baseUrl: 'https://aastu-auth-api.onrender.com');
                          final userData = await userApiDataSource.loginUser({
                            'username': _emailController.text,
                            'password': _passwordController.text,
                          });

                          // Hide loading indicator
                          setState(() {
                            isLoading = false;
                          });

                          // Navigate to the next route
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                          // set logged_in flag to true
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('logged_in', true);
                        } catch (e) {
                          // Handle error and display in SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );

                          // Hide loading indicator
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 3),
              // ----- OR ----- text with divider
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 224, 224, 224),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Color.fromARGB(255, 90, 90, 90),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 224, 224, 224),
                      ),
                    ),
                  ],
                ),
              ),
              //  const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // SignUpScreen()
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: const Color(0xff212121),
                      foregroundColor: const Color(0xff212121),
                      backgroundColor: const Color(0xff212121),
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color.fromARGB(
                              255, 236, 236, 236), // Grey border color
                        ),
                      ),
                    ),
                    // email icon
                    icon: const Icon(
                      Icons.email,
                      color: Color(0xffDFE2E6),
                    ),
                    label: const Text('Sign up with Email',
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 233, 233),
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 19,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid email';
                }
                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'example@gmail.com',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDFE2E6),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDFE2E6),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xffDFE2E6),
                ),
                hintStyle: TextStyle(
                  color: Color(0xffDFE2E6),
                  // Adjust the top padding as needed
                  height: 1.5, // Increase this value to add more top padding
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 1.0), // Adjust the vertical padding as needed
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 19,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _passwordController,
              obscureText: !isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter password",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDFE2E6),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDFE2E6),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),

                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.vpn_key,
                  color: Color(0xffDFE2E6),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xffDFE2E6),
                  // Adjust the top padding as needed
                  height: 1.5, // Increase this value to add more top padding
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 1.0), //
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xffDFE2E6),
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateInputs() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }
}
