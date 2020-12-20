import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  String updatedEmail = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          initialValue: user.email,
          onChanged: (value) {
            setState(() {
              updatedEmail = value;
            });
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible:
            updatedEmail == user.email || updatedEmail == '' ? false : true,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
