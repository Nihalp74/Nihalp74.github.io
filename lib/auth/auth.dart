import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainapp/auth/login_or_signup.dart';
import 'package:mainapp/chat_screen/chat_list_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatListScreen();
          } else {
            return const LoginOrSignup();
          }
        },
      ),
    );
  }
}
