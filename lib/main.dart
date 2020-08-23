import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flash Chat",
      initialRoute: WelcomeScreen.route,
      routes: {
        WelcomeScreen.route: (BuildContext context) => WelcomeScreen(),
        LoginScreen.route: (BuildContext context) => LoginScreen(),
        RegistrationScreen.route: (BuildContext context) =>
            RegistrationScreen(),
        ChatScreen.route: (BuildContext context) => ChatScreen(),
      },
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }
}
