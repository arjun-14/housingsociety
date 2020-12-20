import 'package:flutter/material.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String currentPassword = '';
  String updatedPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
              onChanged: (value) {
                setState(() {
                  currentPassword = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              onChanged: (value) {
                setState(() {
                  updatedPassword = value;
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: currentPassword != '' && updatedPassword != '' ? true : false,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.save,
          ),
        ),
      ),
    );
  }
}
