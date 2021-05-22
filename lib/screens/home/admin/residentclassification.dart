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

    userProfile = FirebaseFirestore.instance
        .collection('user_profile')
        .where('userType', isEqualTo: userType);

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
                                userType != 'admin'
                                    ? ListTile(
                                        onTap: () {
                                          DatabaseService()
                                              .disableAccount(document.id);
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                          'Disable account',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
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
                leading: CircleAvatar(
                  backgroundImage: document.data()['profile_picture'] == ''
                      ? AssetImage('assets/images/default_profile_pic.jpg')
                      : NetworkImage(document.data()['profile_picture']),
                ),
                title: Text(document.data()['name']),
                subtitle: Text(document.data()['wing'] +
                    ' - ' +
                    document.data()['flatno']),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
