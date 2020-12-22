import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/shared/loading.dart';

class RealTimeNoticeUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query notice = FirebaseFirestore.instance
        .collection('module_notice')
        .orderBy('timestamp');
    return StreamBuilder<QuerySnapshot>(
        stream: notice.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Container(
                child: Column(
                  children: [
                    Text(document.data()['title']),
                    Text(document.data()['notice']),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
