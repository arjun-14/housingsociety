import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/shared/loading.dart';

class Contacts extends StatelessWidget {
  static const String id = 'contacts';

  @override
  Widget build(BuildContext context) {
    Query userProfile =
        FirebaseFirestore.instance.collection('user_profile').orderBy('name');
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userProfile.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: document.data()['profile_picture'] == ' '
                      ? AssetImage('assets/images/default_profile_pic.jpg')
                      : NetworkImage(document.data()['profile_picture']),
                ),
                title: Text(
                  document.data()['name'],
                ),
                subtitle: Text(
                  document.data()['wing'] + ' ' + document.data()['flatno'],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {},
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
