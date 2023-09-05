// import 'package:flutter/material.dart';
// import 'package:mainapp/chat_screen/chat_list_screen.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Settings"),
//           elevation: 0,
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (_) => const ChatListScreen()));
//                 },
//                 icon: const Icon(Icons.arrow_back_ios_new_sharp))
//           ],
//         ),
//         backgroundColor: Colors.green[300],
//         body: ListView(),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mainapp/chat_screen/chat_list_screen.dart';
// import 'package:mainapp/signup_screen/phone_signup.dart';
import 'package:mainapp/signup_screen/signup_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _deleteAccount() async {
    final user = _auth.currentUser;

    if (user != null) {
      // Display confirmation dialog
      final confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Account Deletion'),
            content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      );

      if (confirmed == true) {
        // Delete user's data from Firestore
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userDocRef.delete();

        // Delete account and navigate back to login
        await user.delete();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SignUpPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatListScreen()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
            ),
          ],
        ),
        backgroundColor: Colors.green[300],
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            ElevatedButton(
              onPressed: _deleteAccount,
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
