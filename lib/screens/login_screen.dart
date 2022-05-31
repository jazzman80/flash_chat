import 'package:flutter/material.dart';
import 'user_form.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 50.0,
          ),
          child: userForm(
            buttonLabel: 'Login',
          ),
        ),
      ),
    );
  }
}
