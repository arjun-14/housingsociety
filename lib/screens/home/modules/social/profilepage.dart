import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    DocumentReference moduleSocial =
        FirebaseFirestore.instance.collection('module_social').doc(user.uid);
    Query moduleSocialphotos = FirebaseFirestore.instance
        .collection('module_social')
        .doc(user.uid)
        .collection('photos')
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
                    backgroundImage: user.profilePicture == null
                        ? AssetImage('assets/images/default_profile_pic.jpg')
                        : NetworkImage(snapshot.data['profile_picture']),
                    radius: 65,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          snapshot.data['posts'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          snapshot.data['friends'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Posts',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Friends',
                          style: TextStyle(fontSize: 18),
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
                StreamBuilder<QuerySnapshot>(
                  stream: moduleSocialphotos.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 0,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Image.network(
                          document.data()['url'],
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
                // Expanded(
                //   child: GridView.count(
                //     crossAxisCount: 3,
                //     children: snapshot.data['photos'],
                //   ),
                // )
              ],
            ),
          ],
        );
      },
    );
  }
}
