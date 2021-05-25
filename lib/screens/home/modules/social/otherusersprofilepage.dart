import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/social/defaultprofilepage.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  final String uid;
  final String username;
  final bool following;

  UserProfilePage({this.uid, this.username, this.following});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool togglefollowing;
  @override
  void initState() {
    super.initState();
    togglefollowing = widget.following;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        actions: [
          TextButton(
              child: togglefollowing == true
                  ? Text(
                      'Unfollow',
                      style: TextStyle(color: kAmaranth),
                    )
                  : Text(
                      'Follow',
                      style: TextStyle(color: kAmaranth),
                    ),
              onPressed: () {
                setState(() {
                  togglefollowing = !togglefollowing;
                });

                DatabaseService().followUser(user.uid, widget.uid);
              }),
        ],
      ),
      body: ProfilePage(
        uid: widget.uid,
      ),
    );
  }
}
