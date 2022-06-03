import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const FlashChatApp(),
      ),
    );

class FlashChatApp extends StatefulWidget {
  const FlashChatApp({Key? key}) : super(key: key);

  @override
  State<FlashChatApp> createState() => _FlashChatAppState();
}

class _FlashChatAppState extends State<FlashChatApp> {
  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
      theme: appThemeData(context),
    );
  }
}
