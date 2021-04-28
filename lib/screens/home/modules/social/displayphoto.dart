import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/social/reusableposttile.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class DisplayPhoto extends StatelessWidget {
  final String docid;
  final Map likes;
  DisplayPhoto({this.docid, this.likes});
  // final String username;
  // final String profilePicture;
  // final String photo;
  // final int likes;
  // final int comments;
  // final String caption;
  // final String docid;
  // DisplayPhoto({
  //   this.username,
  //   this.profilePicture,
  //   this.photo,
  //   this.likes,
  //   this.comments,
  //   this.caption,
  //   this.docid,
  // });
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    DocumentReference moduleSocialPhotos = FirebaseFirestore.instance
        .collection('module_social_photos')
        .doc(docid);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: moduleSocialPhotos.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              DocumentSnapshot document = snapshot.data;
              print(document);
              return ReusablePostDisplayTile(
                document: document,
                likes: likes,
              );
            }),
      ),
    );
  }
}
