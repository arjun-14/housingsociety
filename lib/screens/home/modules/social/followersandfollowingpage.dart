import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class FollowersAndFollowing extends StatefulWidget {
  final String pageToDisplay;
  FollowersAndFollowing({this.pageToDisplay});

  @override
  _FollowersAndFollowingState createState() => _FollowersAndFollowingState();
}

class _FollowersAndFollowingState extends State<FollowersAndFollowing> {
  String userid = AuthService().userId();
  Query followersdisplay;
  Query followingdisplay;
  List<String> followersUid = [];
  List<String> followingUid = [];
  int initialIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference followers = FirebaseFirestore.instance
        .collection('module_social')
        .doc(userid)
        .collection('followers');
    CollectionReference following = FirebaseFirestore.instance
        .collection('module_social')
        .doc(userid)
        .collection('following');
    if (widget.pageToDisplay == 'following') {
      initialIndex = 1;
    }
    followers.get().then((value) {
      value.docs.forEach((doc) {
        followersUid.add(doc.data()['uid']);
      });
      if (followersUid.isNotEmpty) {
        setState(() {
          followersdisplay = FirebaseFirestore.instance
              .collection('module_social')
              .where('uid', whereIn: followersUid);
        });
      }
    });
    following.get().then((value) {
      value.docs.forEach((doc) {
        followingUid.add(doc.data()['uid']);
      });
      if (followingUid.isNotEmpty) {
        setState(() {
          followingdisplay = FirebaseFirestore.instance
              .collection('module_social')
              .where('uid', whereIn: followingUid);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: <Widget>[
            Tab(
              text: 'Followers',
            ),
            Tab(
              text: 'Following',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            followersdisplay == null
                ? Center(child: Text('Follow someone'))
                : FollowersandFollowingdisplaytile(
                    displaytile: followersdisplay,
                  ),
            followingdisplay == null
                ? Center(child: Text('Nobody is following you yet'))
                : FollowersandFollowingdisplaytile(
                    displaytile: followingdisplay,
                  ),
          ],
        ),
      ),
    );
  }
}

class FollowersandFollowingdisplaytile extends StatelessWidget {
  FollowersandFollowingdisplaytile({this.displaytile});

  final Query displaytile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: displaytile.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return ListTile(
              leading: CircleAvatar(
                  backgroundImage: document.data()['profile_picture'] == ''
                      ? AssetImage('assets/images/default_profile_pic.jpg')
                      : NetworkImage(document.data()['profile_picture'])),
              title: Text(document.data()['username']),
            );
          }).toList(),
        );
      },
    );
  }
}
