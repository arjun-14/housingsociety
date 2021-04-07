import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';

class ResidentClassification extends StatelessWidget {
  final String userType;
  ResidentClassification({this.userType});
  @override
  Widget build(BuildContext context) {
    Query userProfile;
    if (userType == 'admin') {
      userProfile = FirebaseFirestore.instance
          .collection('user_profile')
          .where('userType', isEqualTo: 'admin');
    } else {
      userProfile =
          FirebaseFirestore.instance.collection('user_profile').orderBy('name');
    }

    return StreamBuilder(
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
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          Container(
                            color: kOxfordBlue,
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    userType == 'admin'
                                        ? DatabaseService()
                                            .setAdmin(document.id, 'resident')
                                        : DatabaseService()
                                            .setAdmin(document.id, 'admin');
                                    Navigator.pop(context);
                                  },
                                  title: userType == 'admin'
                                      ? Text('Remove admin')
                                      : Text('Make admin'),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: ListTile(
                title: Text(document.data()['name']),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
