// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mainapp/login_page/login_screen.dart';
import 'package:mainapp/settings/settings_page.dart';
import 'package:mainapp/chat_screen/chat_screen.dart';
import 'package:mainapp/chat_screen/new_chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void signout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the login page or any other page as needed
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Sign Out"),
            ),
          ],
        );
      },
    );
  }

  void _startNewChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewChatScreen(currentUser: currentUser!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat List'),
          actions: [
            IconButton(
              onPressed: () => signout(),
              icon: const Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('participants', arrayContains: currentUser!.uid)
              .orderBy('lastMessageTimestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No chats available.'),
              );
            }

            final chatDocs = snapshot.data!.docs;
            final chats = chatDocs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ChatInfo(
                chatId: doc.id,
                participants: List<String>.from(data['participants']),
                lastMessage: data['lastMessage'],
                lastMessageTimestamp: data['lastMessageTimestamp'].toDate(),
              );
            }).toList();

            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chatInfo = chats[index];
                return ListTile(
                  title: Text(
                      'Chat with ${_getOtherParticipant(chatInfo.participants)}'),
                  subtitle: Text(chatInfo.lastMessage),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatId: chatInfo.chatId,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _startNewChat,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  String _getOtherParticipant(List<String> participants) {
    return participants
        .firstWhere((participant) => participant != currentUser!.uid);
  }
}

class ChatInfo {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTimestamp;

  ChatInfo({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTimestamp,
  });
}
