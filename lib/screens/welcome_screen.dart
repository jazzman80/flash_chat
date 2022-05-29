import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Welcome Screen'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ChatScreen.id);
            },
            child: Text('Chat Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            child: Text('Login Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            child: Text('Registration Screen'),
          ),
        ],
      ),
    );
  }
}
