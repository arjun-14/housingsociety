import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';

class RealTimeCommentUpdates extends StatelessWidget {
  final String docid;
  final social;
  RealTimeCommentUpdates({this.docid, this.social});
  @override
  Widget build(BuildContext context) {
    Query moduleComplaintUserComments = social == true
        ? FirebaseFirestore.instance
            .collection('module_social_photos_comments')
            .where('docid', isEqualTo: docid)
            .orderBy('timestamp')
        : FirebaseFirestore.instance
            .collection('module_complaint_comments')
            .where('docid', isEqualTo: docid)
            .orderBy('timestamp');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: moduleComplaintUserComments.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return ListView(
          children: snapshot.data.docs
              .map((DocumentSnapshot<Map<String, dynamic>> document) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kXiketic,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: ListTile(
                  title: Text(document.data()['userName']),
                  subtitle: Text(document.data()['comment']),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
