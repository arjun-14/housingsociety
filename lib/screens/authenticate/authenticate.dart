import 'package:flutter/material.dart';
import 'package:shivalikcityapp/screens/authenticate/register.dart';

import 'logIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogIn = true;
  void toggleView() {
    setState(() {
      showLogIn = !showLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogIn ? LogIn(toggle: toggleView) : Register(toggle: toggleView);
  }
}
