import 'package:currency_conversion/screens/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/Constants.dart';
import '../utils/database_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late DatabaseReference signupdb =
      FirebaseDatabase.instance.ref('Signup Database');
  late DatabaseReference logindb =
      FirebaseDatabase.instance.ref('Login Database');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null) {
        await signupRealtimeDatabase(userCredential.user!.uid);
        await loginRealtimeDatabase(userCredential.user!.uid);
        await DatabaseService.getUserData(
            context, "${userCredential.user!.uid.toString()}");
        AppDesignSystem.showToastMessage(
            'Signup successful for \t ${userCredential.user!.email}');
        debugPrint('Signup successful for \t ${userCredential.user!.email}');
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
      AppDesignSystem.showToastMessage('${e.toString()}');
      debugPrint(e.toString());
    }
  }

  Future<void> signupRealtimeDatabase(String uid) async {
    try {
      signupdb.child(uid).set({
        'ID': uid.toString(),
        'Name': nameController.text,
        'Email': emailController.text,
        'Phone No': phoneController.text,
        'Password': passwordController.text,
        'Date Time': DateTime.now().toString()
      });
    } catch (e) {
      debugPrint("Error: User data not saving in RealTime Database 'Sign up':");
    }
  }

  Future<void> loginRealtimeDatabase(String uid) async {
    try {
      logindb.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
        'ID': uid.toString(),
        'Email': emailController.text,
        'Date Time': DateTime.now().toString()
      });
    } catch (e) {
      debugPrint("Error: User data not saving in RealTime Database 'Log in':");
    }
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300,
            height: 800,
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      "assets/img/pic-01.png",
                      height: MediaQuery.sizeOf(context).height * 0.25,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Signup Form',
                      style: AppDesignSystem.headingStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: AppDesignSystem.inputFieldDecoration('Name'),
                    style: AppDesignSystem.inputFieldTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
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
                      controller: phoneController,
                      decoration: AppDesignSystem.inputFieldDecoration('Phone'),
                      style: AppDesignSystem.inputFieldTextStyle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone no';
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
                          signUp();
                        }
                      },
                      child: Constants.btn("Sign up")),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?\t",
                        style: AppDesignSystem.hintText,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          "Login",
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
