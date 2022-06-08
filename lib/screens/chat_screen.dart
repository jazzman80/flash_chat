import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String _message = '';
  final TextEditingController _textController = TextEditingController();

  void getCurrentUser() {
    final currentUser = _auth.currentUser;
    print(currentUser?.email);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('messages').snapshots(),
          builder: (context, snapshot) {
            List<Widget> messages = [];
            if (snapshot.hasData) {
              for (var message in snapshot.data!.docs) {
                Widget newMessage =
                    Text('${message['sender']} : ${message['text']}');
                messages.add(newMessage);
              }
            }
            return Column(
              children: messages,
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.primary,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_textController.text != '') {
                      _firestore.collection('messages').add(
                        {
                          'text': _textController.text,
                          'sender': _auth.currentUser?.email,
                        },
                      );
                    }
                    setState(() {
                      _textController.text = '';
                    });
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
