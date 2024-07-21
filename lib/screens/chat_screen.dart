import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/message.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  ChatScreen({required this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _chatRef =
      FirebaseDatabase.instance.ref().child('Chats');
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatRef.child(widget.chatId).child('messages').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> messagesMap =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  List<MessageModel> messages = messagesMap.values
                      .map((e) =>
                          MessageModel.fromMap(Map<String, dynamic>.from(e)))
                      .toList();
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(messages[index]);
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String messageId =
          _chatRef.child(widget.chatId).child('messages').push().key!;
      MessageModel message = MessageModel(
        senderId: _auth.currentUser!.uid,
        text: _messageController.text,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        type: 'text',
      );
      _chatRef
          .child(widget.chatId)
          .child('messages')
          .child(messageId)
          .set(message.toMap());
      _messageController.clear();
    }
  }
}
