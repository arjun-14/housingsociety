import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/shared/loading.dart';

class ShowResidents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> userProfile =
        FirebaseFirestore.instance.collection('user_profile').orderBy('name');
    return Scaffold(
      appBar: AppBar(
        title: Text('Residents'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                    document.data()['wing'] + ' ' + document.data()['flatno']),
                onTap: () {
                  Navigator.pop(context, [
                    document.id,
                    document.data()['name'],
                    document.data()['phone_no'],
                    document.data()['wing'],
                    document.data()['flatno']
                  ]);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
