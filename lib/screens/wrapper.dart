import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/authenticate/authenticate.dart';
import 'package:housingsociety/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _messaging.getToken().then((token) => print(token));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return user == null ? Authenticate() : Home();
  }
}
