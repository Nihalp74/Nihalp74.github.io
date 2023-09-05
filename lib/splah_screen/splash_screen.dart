import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mainapp/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo 
              Image.asset(
                'assets/images/logo.png',
                height: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator.adaptive()
            ],
          ),
        ),
      ),
    );
  }
}
