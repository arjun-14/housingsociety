import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/models/user.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final CurrentUser user = CurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            icon: Icon(Icons.ac_unit_outlined),
            onPressed: () {
              print(user.uid);
            },
          ),
        ],
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Text('a1'),
          ),
          Expanded(
            child: Text('a2'),
          )
        ],
      ),
    );
  }
}
