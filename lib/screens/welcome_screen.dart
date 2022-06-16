import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );

  late final Animation<double> _opacityAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceIn,
  );

  @override
  void initState() {
    super.initState();

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 50.0,
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                'Flash Chat',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Text('Login'),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
