import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class HomePageSocial extends StatelessWidget {
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
              children:
                  photosSnapshot.data.docs.map((DocumentSnapshot document) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              document.data()['profile_picture'] == null
                                  ? AssetImage(
                                      'assets/images/default_profile_pic.jpg')
                                  : NetworkImage(
                                      document.data()['profile_picture']),
                        ),
                        title: Text(document.data()['username']),
                      ),
                      Image.network(document.data()['url']),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: kAmaranth,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.chat_bubble_outline,
                                color: kAmaranth,
                              ),
                              onPressed: () {}),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          document.data()['likes'].toString() + ' likes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                              children: [
                                TextSpan(
                                  text: document.data()['username'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text: '  ' + document.data()['caption'])
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
