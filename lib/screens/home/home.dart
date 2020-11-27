import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          AuthService().signOut();
        },
        child: Text('Logout'),
      ),
    );
  }
}
