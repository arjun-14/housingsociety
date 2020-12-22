import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  static const String id = 'edit_name';
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  String updatedName = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    final userName = AuthService().userName();

    return loading == true
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit your name'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                initialValue: userName,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    updatedName = value;
                  });
                },
              ),
            ),
            floatingActionButton: Visibility(
              visible:
                  updatedName == userName || updatedName == '' ? false : true,
              child: FloatingActionButton(
                child: Icon(
                  Icons.save,
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = DatabaseService()
                      .updateProfileName(user.uid, updatedName);
                  if (result != null) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  }
                  print(result);

                  print(updatedName);
                },
              ),
            ),
          );
  }
}
