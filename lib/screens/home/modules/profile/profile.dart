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
          FlatButton(
            onPressed: () {
              print('clicked');
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              print('clicked');
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Email address',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              print('clicked');
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Change password',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
