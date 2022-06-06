import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'user_form.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: 'logo',
                  child: Center(
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Enter your email'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Enter password'),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential newUser =
                        await _auth.signInWithEmailAndPassword(
                            email: _email, password: _password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } on Exception catch (e) {
                    print(e);
                  }
                },
                child: const Text('Login'),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
