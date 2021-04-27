import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/social/reusableposttile.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class HomePageSocial extends StatefulWidget {
  @override
  _HomePageSocialState createState() => _HomePageSocialState();
}

class _HomePageSocialState extends State<HomePageSocial> {
  Map<String, dynamic> likes;
  CollectionReference moduleSocialPhotosLikes =
      FirebaseFirestore.instance.collection('module_social_photos_likes');
  dynamic userid = AuthService().userId();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUSerLikes();
  }

  void getCurrentUSerLikes() async {
    moduleSocialPhotosLikes
        .doc(userid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      if (documentSnapshot.exists) {
        setState(() {
          likes = documentSnapshot.data();
        });
      } else {
        setState(() {
          likes = {};
        });
      }
    });
    print(likes);
    // DocumentSnapshot value = await moduleComplaintUserLikes.doc(userid).get();
    // setState(() {
    //   likes = value.data();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    List<String> usersFollowed = [user.uid];
    CollectionReference moduleSocial = FirebaseFirestore.instance
        .collection('module_social')
        .doc(user.uid)
        .collection('following');

    return StreamBuilder(
      stream: moduleSocial.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text('Start following someone');
        }
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        snapshot.data.docs.forEach((user) {
          usersFollowed.add(user.data()['uid']);
        });

        Query moduleSocialPhotosCurrentUser = FirebaseFirestore.instance
            .collection('module_social_photos')
            .where('uid', whereIn: usersFollowed)
            .orderBy('timestamp', descending: true);
        return StreamBuilder(
          stream: moduleSocialPhotosCurrentUser.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> photosSnapshot) {
            if (photosSnapshot.hasError) {
              return Text('Something went wrong');
            }
            if (photosSnapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return ListView(
              children:
                  photosSnapshot.data.docs.map((DocumentSnapshot document) {
                return ReusablePostDisplayTile(
                  document: document,
                  likes: likes,
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
