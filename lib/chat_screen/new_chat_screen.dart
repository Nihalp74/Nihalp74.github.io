import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mainapp/chat_screen/chat_screen.dart';

class NewChatScreen extends StatelessWidget {
  final User currentUser;

  const NewChatScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start New Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No contacts available.'),
            );
          }

          final contactDocs = snapshot.data!.docs;
          final contacts = contactDocs
              .map((doc) => ContactInfo(
                    contactId: doc.id,
                    contactName:
                        doc['first name'], // Check if 'name' field exists
                  ))
              .where((contactInfo) => contactInfo.contactId != currentUser.uid)
              .toList();

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contactInfo = contacts[index];
              return ListTile(
                title: Text(contactInfo.contactName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chatId: currentUser.uid,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ContactInfo {
  final String contactId;
  final String contactName;

  ContactInfo({
    required this.contactId,
    required this.contactName,
  });
}
