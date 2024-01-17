// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/Constants.dart';
import '../utils/database_service.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late DatabaseReference databaseref =
      FirebaseDatabase.instance.ref('Login Database');

  Future<void> login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        await saveUserData(userCredential.user!.uid.toString());
        await DatabaseService.getUserData(
            context, userCredential.user!.uid.toString());

        AppDesignSystem.showToastMessage(
            'Login successful for \t ${userCredential.user!.email}');
        debugPrint('Login successful for \t ${userCredential.user!.email}');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code != '') {
        AppDesignSystem.showToastMessage(e.toString());
        debugPrint(e.toString());
      } else {
        AppDesignSystem.showToastMessage("Error");
        debugPrint("Error");
      }
    } catch (e) {
      AppDesignSystem.showToastMessage(e.toString());
      debugPrint(e.toString());
    }
  }

  Future<void> saveUserData(String uid) async {
    try {
      databaseref.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
        'ID': uid.toString(),
        'Email': emailController.text,
        'Date Time': DateTime.now().toString()
      });
    } catch (e) {
      AppDesignSystem.showToastMessage(
          'Error: User data not saving in RealTime Database:');
      debugPrint("Error: User data not saving in RealTime Database:");
    }
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      "assets/img/pic-01.png",
                      height: MediaQuery.sizeOf(context).height * 0.25,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Login Form',
                      style: AppDesignSystem.headingStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: emailController,
                      decoration: AppDesignSystem.inputFieldDecoration('Email'),
                      style: AppDesignSystem.inputFieldTextStyle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration:
                          AppDesignSystem.inputFieldDecoration('Password'),
                      style: AppDesignSystem.inputFieldTextStyle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        if (key.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Constants.btn("Login")),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?\t",
                        style: AppDesignSystem.hintText,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                        },
                        child: Text(
                          "Signup",
                          style: AppDesignSystem.linkTextStyle.copyWith(
                            color: const Color(0xFFFABA49),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
