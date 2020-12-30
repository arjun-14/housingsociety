import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealTimeCommentUpdates extends StatelessWidget {
  final String docid;
  RealTimeCommentUpdates({this.docid});
  @override
  Widget build(BuildContext context) {
    Query moduleComplaintUserComments = FirebaseFirestore.instance
        .collection('module_complaint_comments')
        .doc(docid)
        .collection('comments')
        .orderBy('timestamp');
    return StreamBuilder<QuerySnapshot>(
      stream: moduleComplaintUserComments.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: Text(document.data()['userName']),
              subtitle: Text(document.data()['comment']),
            );
          }).toList(),
        );
      },
    );
  }
}
