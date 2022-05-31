import 'package:flutter/material.dart';

ThemeData appThemeData(context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      accentColor: Colors.lightBlueAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(300.0),
        ),
        textStyle: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(15.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(300.0),
        ),
      ),
    ),
  );
}
