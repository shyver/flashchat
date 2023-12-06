import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlurryModalProgressHUD(
        dismissible: true,
        progressIndicator: SpinKitSpinningLines(
          color: Colors.blueAccent,
        ),
        inAsyncCall: showSpinner,
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
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Email.'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            if (password.length <= 6) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        icon: Icon(LineIcons.exclamationCircle),
                                        title: Text('password too short'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'cancel');
                                              },
                                              child: Text('retry'))
                                        ],
                                      ));
                            }
                          }
                          //Implement registration functionality.
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
