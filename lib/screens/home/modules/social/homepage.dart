import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/complaints/comments.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    CollectionReference moduleSocialPhotos_ =
        FirebaseFirestore.instance.collection('module_social_photos');

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
                                      document.data()['profile_picture'],
                                    ),
                        ),
                        title: Text(document.data()['username']),
                      ),
                      GestureDetector(
                        onDoubleTap: () {
                          likes.containsKey(document.id)
                              ? likes[document.id] = !likes[document.id]
                              : likes[document.id] = true;
                          DatabaseService().updateLikes(
                            moduleSocialPhotos_,
                            moduleSocialPhotosLikes,
                            document.id,
                            document.data()['likes'],
                            user.uid,
                          );
                        },
                        child: Image.network(
                          document.data()['url'],
                          loadingBuilder: (context, child, progress) {
                            return progress == null ? child : Loading();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                likes.containsKey(document.id)
                                    ? likes[document.id] == true
                                        ? Icons.favorite
                                        : Icons.favorite_border
                                    : Icons.favorite_border,
                                color: kAmaranth,
                              ),
                              onPressed: () {
                                likes.containsKey(document.id)
                                    ? likes[document.id] = !likes[document.id]
                                    : likes[document.id] = true;

                                DatabaseService().updateLikes(
                                  moduleSocialPhotos_,
                                  moduleSocialPhotosLikes,
                                  document.id,
                                  document.data()['likes'],
                                  user.uid,
                                );
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.chat_bubble_outline,
                                color: kAmaranth,
                              ),
                              onPressed: () {
                                showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => Comments(
                                          social: true,
                                          docid: document.id,
                                          socialusername:
                                              document.data()['username'],
                                        ));
                              }),
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
