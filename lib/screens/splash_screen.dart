import 'package:currency_conversion/screens/home_screen.dart';
import 'package:currency_conversion/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(Duration(milliseconds: 1500), () {
      final User? user = auth.currentUser;
      if (user != null) {
        auth.signOut().then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2937),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/img/splashscreen.json',
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16), // Adjust the spacing between Lottie animation and text
            Text(
              'Currency Converter',
              style: TextStyle(
                color: Color(0xFFFABA49),
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Add font weight (options: normal, bold, etc.)
                // Add more text styling properties as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
