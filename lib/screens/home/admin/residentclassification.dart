import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class ResidentClassification extends StatelessWidget {
  final String userType;
  ResidentClassification({this.userType});

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> userProfile;
    final user = Provider.of<CurrentUser>(context);
    userProfile = FirebaseFirestore.instance
        .collection('user_profile')
        .where('userType', isEqualTo: userType);

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
            return GestureDetector(
              onTap: document.id == user.uid
                  ? null
                  : () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Wrap(
                              children: [
                                Container(
                                  color: kOxfordBlue,
                                  child: Column(
                                    children: [
                                      userType != 'admin' &&
                                              userType != 'disabled'
                                          ? ListTile(
                                              onTap: () {
                                                DatabaseService()
                                                    .disableAccount(
                                                        document.id);
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
                                          userType == 'disabled'
                                              ? DatabaseService()
                                                  .enableAccount(document.id)
                                              : userType == 'admin'
                                                  ? DatabaseService().setAdmin(
                                                      document.id, 'resident')
                                                  : DatabaseService().setAdmin(
                                                      document.id, 'admin');
                                          Navigator.pop(context);
                                        },
                                        title: userType == 'disabled'
                                            ? Text(
                                                'Enable Account',
                                                style: TextStyle(
                                                  color: kMediumAquamarine,
                                                ),
                                              )
                                            : userType == 'admin'
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
