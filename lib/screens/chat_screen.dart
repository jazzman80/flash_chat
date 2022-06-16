import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final TextEditingController _textController = TextEditingController();

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: const [
          SignOutButton(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            MessagesArea(),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.sender,
      required this.text,
      required this.isUserMessage})
      : super(key: key);
  final String sender;
  final String text;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      child: Column(
        crossAxisAlignment:
            isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft:
                    isUserMessage ? const Radius.circular(10.0) : Radius.zero,
                bottomLeft: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0),
                topRight:
                    isUserMessage ? Radius.zero : const Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            color: isUserMessage
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () async {
        await _auth.signOut();
        Navigator.pop(context);
      },
    );
  }
}

class MessagesArea extends StatelessWidget {
  const MessagesArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messages = [];
          if (snapshot.hasData) {
            for (var message in snapshot.data!.docs) {
              MessageBubble newMessage = MessageBubble(
                sender: message['sender'],
                text: message['text'],
                isUserMessage: _auth.currentUser!.email == message['sender'],
              );
              messages.add(newMessage);
            }
          }
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return messages[index];
            },
          );
        },
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          NewMessageField(),
          SendButton(),
        ],
      ),
    );
  }
}

class NewMessageField extends StatelessWidget {
  const NewMessageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class SendButton extends StatefulWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_textController.text != '') {
          _firestore.collection('messages').add(
            {
              'text': _textController.text,
              'sender': _auth.currentUser?.email,
              'timestamp': Timestamp.now(),
            },
          );
        }
        setState(() {
          _textController.clear();
        });
      },
      child: Text(
        'Send',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
