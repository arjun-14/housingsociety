import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/profile/editName.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            //value: AuthService().userName(),
            value: user.name,
            onpress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditName(),
                ),
              );
            },
          ),
          ReusableProfileTile(
            label: 'Email',
            value: user.email,
          ),
          ReusableProfileTile(
            label: 'Change password',
            value: ' ',
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Delete account',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReusableProfileTile extends StatelessWidget {
  final String label;
  final String value;
  final Function onpress;
  ReusableProfileTile({this.label, this.value, this.onpress});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onpress,
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
