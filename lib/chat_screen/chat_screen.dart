import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final currentuser = FirebaseFirestore.instance.collection("users").doc();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      // ignore: avoid_print
      print('FCM token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var message = snapshot.data!.docs[index]['message'];
                      var timestamp =
                          snapshot.data!.docs[index]['timestamp'].toDate();
                      var isSentMessage =
                          snapshot.data!.docs[index]['isSentMessage'] ?? false;

                      // Determine alignment and color based on whether the message is sent or received
                      var alignment = isSentMessage
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight;
                      var bgColor = isSentMessage ? Colors.blue : Colors.green;
                      var padding = isSentMessage
                          ? const EdgeInsets.only(right: 65, left: 8)
                          : const EdgeInsets.only(left: 65, right: 8);

                      var formattedTimestamp =
                          DateFormat('mm:ss').format(timestamp);

                      return Padding(
                        padding: padding,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(8.0),
                            alignment: alignment,
                            color: bgColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(message),
                                ),
                                SizedBox(
                                  height: 4.0,
                                  width: 200,
                                  child: Container(
                                    width: message.length.toDouble(),
                                  ),
                                ),
                                Text(formattedTimestamp),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Form(
            key: _formKey,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance.collection('messages').add({
                        'message': _messageController.text,
                        'timestamp': FieldValue.serverTimestamp(),
                        'isSentMessage': true,
                      });
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
