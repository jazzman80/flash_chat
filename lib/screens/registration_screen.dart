import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
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
                  decoration:
                      const InputDecoration(hintText: 'Enter your email'),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
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
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      UserCredential newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('email', email);
                      await prefs.setString('password', password);
                      setState(() {
                        _showSpinner = false;
                      });
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } on Exception catch (e) {
                      print(e);
                      setState(() {
                        _showSpinner = false;
                      });
                    }
                  },
                  child: const Text('Register'),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
