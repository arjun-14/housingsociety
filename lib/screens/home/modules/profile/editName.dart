import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  String updatedName;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    final userName = user.name ?? AuthService().userName();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          initialValue: userName,
          onChanged: (value) {
            setState(() {
              updatedName = value;
            });
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: updatedName == userName || updatedName == '' ? false : true,
        child: FloatingActionButton(
          child: Icon(
            Icons.save,
          ),
          onPressed: () {
            print(updatedName);
          },
        ),
      ),
    );
  }
}
