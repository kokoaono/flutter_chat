import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/controllers/auth_controller.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:get/get.dart';

class MessagesStream extends GetView<AuthController> {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.db.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ),
          );
        }
        if (snapshot.hasData) {
          final messagesList = snapshot.data?.docs.toList().reversed;
          for (var message in messagesList!) {
            final messageText = message['text'];
            final messageSender = message['sender'];

            final currentUser = controller.currentUser;

            if (currentUser == messageSender) {}

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
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
