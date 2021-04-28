import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/social/defaultprofilepage.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  final String uid;
  final String username;
  UserProfilePage({this.uid, this.username});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        actions: [
          IconButton(
              icon: Icon(
                Icons.person_add,
                color: kAmaranth,
              ),
              onPressed: () {
                DatabaseService().followUser(user.uid, uid);
              })
        ],
      ),
      body: ProfilePage(
        uid: uid,
      ),
    );
  }
}
