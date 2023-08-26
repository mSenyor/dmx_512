import 'package:flutter/material.dart';
import 'package:dmx_512/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dmx_512/components/messages_stream.dart';

late User loggedInUser;
final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _auth.signOut();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //TODO: remove commented print before build
        // print(loggedInUser.email);
      }
    } catch (e) {
      //TODO: remove commented print before build
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? email = _auth.currentUser?.email;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: Row(
          children: [
            Text(
              'Chat'.toUpperCase(),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              '$email',
              style: const TextStyle(
                fontSize: 15.0,
                color: kHintTextColor,
              ),
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: kRegisterButtonColor,
              width: 2.0,
            ),
          ),
          color: kChatBackgroundColor,
        ),
        // color: kChatBackgroundColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessagesStream(
                firestore: _firestore,
                user: _auth.currentUser,
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        //TODO: add behaviors for when a user presses enter while in the field
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        style: TextStyle(
                          color: kBrightTextColor,
                        ),
                        cursorColor: kBrightTextColor,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection(kMainChatCollectionName).add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'displayName': loggedInUser.displayName,
                          'timestamp': DateTime.timestamp(),
                        });
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
