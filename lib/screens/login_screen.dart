import 'package:flash_chat/components/AuthButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:modal_progress_hud/modal_progress_hud.dart' as modal_hud;

class LoginScreen extends StatefulWidget {
  static const String route = "login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode passwordFocus = FocusNode();
  String email;
  String password;
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: modal_hud.ModalProgressHUD(
        inAsyncCall: loading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: kTextInputFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    focusNode: passwordFocus,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextInputFieldDecoration.copyWith(
                      hintText: 'Enter your password.',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  AuthButton(
                    text: 'Log In',
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      auth
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      )
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushNamed(context, ChatScreen.route);
                      }).catchError((error) {
                        print(error);
                        setState(() {
                          loading = false;
                        });
                      });
                    },
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
