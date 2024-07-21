import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lapr Chat'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Sign in with Google logic
            User? user = await _signInWithGoogle();
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(chatId: 'exampleChatId')),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }

  Future<User?> _signInWithGoogle() async {
    // Implement your Google Sign-In logic here
  }
}
