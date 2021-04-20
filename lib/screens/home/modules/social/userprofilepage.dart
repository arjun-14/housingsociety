import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/social/defaultprofilepage.dart';

class UserProfilePage extends StatelessWidget {
  final String uid;
  final String username;
  UserProfilePage({this.uid, this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: ProfilePage(
        uid: uid,
      ),
    );
  }
}
