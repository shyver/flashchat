import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/reusable_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: SpinKitSpinningLines(
          color: Colors.lightBlue,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                    tag: 'logo',
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email.',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password.'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  reusableButton(
                      buttonColor: Colors.lightBlueAccent,
                      buttonText: 'Log In',
                      pressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    icon: Icon(LineIcons.exclamationCircle),
                                    title: Text('invalid email or password.'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'cancel');
                                          },
                                          child: Text('retry'))
                                    ],
                                  ));
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

dynamic FieldDecoration() {
  return InputDecoration(
    hintStyle: TextStyle(
      color: Colors.grey.shade600,
    ),
    hintText: 'Enter your email.',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
