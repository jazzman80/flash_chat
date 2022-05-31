import 'package:flutter/material.dart';

Widget userForm({required String buttonLabel}) {
  return Column(
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
        decoration: InputDecoration(hintText: 'Enter your email'),
      ),
      SizedBox(
        height: 15.0,
      ),
      TextField(
        decoration: InputDecoration(hintText: 'Enter password'),
      ),
      SizedBox(
        height: 30.0,
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text(buttonLabel),
      ),
      Expanded(
        flex: 1,
        child: Container(),
      ),
    ],
  );
}
