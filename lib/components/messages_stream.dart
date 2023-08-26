import 'package:dmx_512/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dmx_512/components/single_message_bubble.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({
    super.key,
    required FirebaseFirestore firestore,
    required this.user,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection(kMainChatCollectionName)
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        List<SingleMessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data?.docs.reversed;
          for (var message in messages!) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageNickname = message.get('displayName');

            // DateTime dt = (map['timestamp'] as Timestamp).toDate();
            final timestamp = (message.get('timestamp') as Timestamp).toDate();
            final userEmail = user?.email;
            final messageBubble = SingleMessageBubble(
              sender: messageSender,
              text: messageText,
              displayName: messageNickname,
              isMe: userEmail == messageSender,
              time: timestamp.toString(),
            );
            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
