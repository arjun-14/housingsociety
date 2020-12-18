import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
          ),
          ReusableProfileTile(
            label: 'Name',
            value: user.name,
          ),
          ReusableProfileTile(
            label: 'Email address',
            value: user.email,
          ),
          ReusableProfileTile(
            label: 'Change password',
            value: ' ',
          ),
        ],
      ),
    );
  }
}

class ReusableProfileTile extends StatelessWidget {
  final String label;
  final String value;
  ReusableProfileTile({this.label, this.value});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        print('clicked');
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
