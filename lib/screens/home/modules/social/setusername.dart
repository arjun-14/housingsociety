import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';

class SetUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    CollectionReference moduleSocialUserNames =
        FirebaseFirestore.instance.collection('module_social_usernames');
    String username = '';
    void showSnackbar(String content) {
      final snackBar = SnackBar(
        content: Text(
          content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: kOxfordBlue,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            onChanged: (value) {
              username = value;
            },
            decoration: InputDecoration(
              labelText: 'Set Username',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (username.trim() == '') {
            showSnackbar('Username cannot be empty');
          } else if (username.contains(' ')) {
            showSnackbar('Username should not contain spaces');
          } else if (username.toLowerCase() != username) {
            showSnackbar('Username should not contain uppercase characters');
          } else {
            DocumentReference documentReference =
                moduleSocialUserNames.doc(username);
            documentReference.get().then((doc) {
              if (doc.exists) {
                showSnackbar('Username already exists');
              } else {
                DatabaseService().setUserNameSocial(username, user.uid);
              }
            });
          }
          print(username);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
