import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';

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
          return Loading();
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
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
