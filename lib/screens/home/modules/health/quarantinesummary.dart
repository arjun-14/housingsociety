import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';

class QuarantineSummary extends StatelessWidget {
  static const String id = 'quarantine_summary';
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> userProfile = FirebaseFirestore.instance
        .collection('user_profile')
        .orderBy('health')
        .where('health', isNotEqualTo: 'Healthy');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: userProfile.snapshots(),
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
            return ListTile(
              title: Text(document.data()['name']),
              subtitle: Text(
                  document.data()['wing'] + '  ' + document.data()['flatno']),
              trailing: Text(
                document.data()['health'],
                style: TextStyle(
                  color: kAmaranth,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
