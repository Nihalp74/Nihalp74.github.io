import 'package:flutter/material.dart';
import 'package:mainapp/login_page/login_screen.dart';
// import 'package:mainapp/signup_screen/phone_signup.dart';
import 'package:mainapp/signup_screen/signup_screen.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return const LoginPage();
    } else {
      return const SignUpPage();
    }
  }
}
