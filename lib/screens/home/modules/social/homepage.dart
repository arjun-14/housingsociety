import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class HomePageSocial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    List<String> usersFollowed = [];
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
        print(usersFollowed);
        Query moduleSocialPhotos = FirebaseFirestore.instance
            .collection('module_social_photos')
            .where('uid', whereIn: usersFollowed)
            .orderBy('timestamp', descending: true);
        return StreamBuilder(
          stream: moduleSocialPhotos.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> photosSnapshot) {
            if (photosSnapshot.hasError) {
              return Text('Something went wrong');
            }
            if (photosSnapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return ListView(
              children: photosSnapshot.data.docs
                  .map((DocumentSnapshot documentSnapshot) {
                return Image.network(documentSnapshot.data()['url']);
              }).toList(),
            );
          },
        );
      },
    );
  }
}
