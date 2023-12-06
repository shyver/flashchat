import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/reusable_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                  tag: 'logo',
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      speed: Duration(milliseconds: 250),
                      textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            reusableButton(
                buttonColor: Colors.lightBlueAccent,
                buttonText: 'Log In',
                pressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                  //Go to login screen.
                }),
            reusableButton(
                buttonColor: Colors.blueAccent,
                buttonText: 'Register',
                pressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
