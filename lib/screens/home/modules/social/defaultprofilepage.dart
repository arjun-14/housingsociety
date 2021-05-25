import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/screens/home/modules/social/displayphoto.dart';
import 'package:housingsociety/screens/home/modules/social/followersandfollowingpage.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({this.uid});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> likes;
  CollectionReference<Map<String, dynamic>> moduleSocialPhotosLikes =
      FirebaseFirestore.instance.collection('module_social_photos_likes');
  dynamic userid = AuthService().userId();
  @override
  void initState() {
    super.initState();
    getCurrentUSerLikes();
  }

  void getCurrentUSerLikes() async {
    moduleSocialPhotosLikes
        .doc(userid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
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
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    String uid;
    widget.uid == null ? uid = user.uid : uid = widget.uid;
    DocumentReference<Map<String, dynamic>> moduleSocial =
        FirebaseFirestore.instance.collection('module_social').doc(uid);
    Query<Map<String, dynamic>> moduleSocialphotos = FirebaseFirestore.instance
        .collection('module_social_photos')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true);

    return StreamBuilder<DocumentSnapshot>(
      stream: moduleSocial.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: snapshot.data['profile_picture'] == ''
                        ? AssetImage('assets/images/default_profile_pic.jpg')
                        : NetworkImage(snapshot.data['profile_picture']),
                    radius: 65,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data['posts'].toString(),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FollowersAndFollowing(
                                pageToDisplay: 'followers',
                                username: snapshot.data['username'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              snapshot.data['followers'].toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Center(
                              child: Text(
                                'Followers',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FollowersAndFollowing(
                                pageToDisplay: 'following',
                                username: snapshot.data['username'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              snapshot.data['following'].toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Center(
                              child: Text(
                                'Following',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: moduleSocialphotos.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loading();
                    }

                    return GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      children: snapshot.data.docs.map(
                          (DocumentSnapshot<Map<String, dynamic>> document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DisplayPhoto(
                                docid: document.id,
                                likes: likes,
                              );
                            }));
                          },
                          child: Image.network(
                            document.data()['url'],
                            semanticLabel: 'User uploads',
                            loadingBuilder: (context, child, progress) {
                              return progress == null ? child : Loading();
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
