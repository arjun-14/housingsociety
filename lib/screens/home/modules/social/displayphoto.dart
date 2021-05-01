import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/social/reusableposttile.dart';
import 'package:housingsociety/shared/loading.dart';

class DisplayPhoto extends StatelessWidget {
  final String docid;
  final Map likes;
  DisplayPhoto({this.docid, this.likes});

  @override
  Widget build(BuildContext context) {
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
