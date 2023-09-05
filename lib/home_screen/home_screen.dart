// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mainapp/chat_screen/chat_list_screen.dart';
// import 'package:mainapp/chat_screen/chat_screen.dart';
// import 'package:mainapp/settings/settings_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final currentUser = FirebaseAuth.instance.currentUser!;

//   void signOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.greenAccent,
//           title: const Text("Title of the app"),
//           elevation: 0,
//           actions: [
//             IconButton(
//               onPressed: signOut,
//               icon: const Icon(Icons.logout),
//             ),
//             IconButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (_) => const SettingsPage()));
//                 },
//                 icon: const Icon(Icons.menu))
//           ],
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('contacts')
//                     .where('userId', isEqualTo: currentUser.uid)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Text('No contacts available.');
//                   }

//                   final contactDocs = snapshot.data!.docs;
//                   final contactId = contactDocs
//                       .first.id; // Assuming you want the first contact

//                   return FloatingActionButton(
//                     child: const Icon(Icons.chat),
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (_) => ChatScreen(),
//                       ));
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
