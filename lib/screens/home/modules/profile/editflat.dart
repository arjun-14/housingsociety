import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';
import 'package:provider/provider.dart';

class EditFlat extends StatefulWidget {
  static const String id = 'EditFlatNo';

  @override
  _EditFlatState createState() => _EditFlatState();
}

class _EditFlatState extends State<EditFlat> {
  String wing = '';
  String flatno = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Flat no'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    wing = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.apartment),
                  labelText: 'Wing',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    flatno = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Flat No',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: wing != '' && flatno != '',
        child: FloatingActionButton(
          onPressed: () {
            DatabaseService().updateFlatNo(user.uid, wing, flatno);
            Navigator.pop(context);
          },
          child: Icon(Icons.done),
        ),
      ),
    );
  }
}
