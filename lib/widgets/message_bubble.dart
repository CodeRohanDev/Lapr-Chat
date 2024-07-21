import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message.text),
      subtitle: Text(message.senderId),
      leading: CircleAvatar(
        backgroundImage:
            NetworkImage('https://example.com/path/to/profile/picture'),
      ),
    );
  }
}
