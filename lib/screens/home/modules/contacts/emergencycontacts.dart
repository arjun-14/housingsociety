import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/screens/home/modules/contacts/addemergencycontact.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> contactsEmergency = FirebaseFirestore.instance
        .collection('module_contacts_emergency')
        .orderBy('name');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: contactsEmergency.snapshots(),
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
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: kOxfordBlue,
                        content: Text('Delete Contact?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                DatabaseService()
                                    .deleteEmergencyContact(document.id);
                                Navigator.pop(context);
                              },
                              child: Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                        ],
                      );
                    });
              },
              leading: CircleAvatar(
                backgroundImage: document.data()['profile_picture'] == ''
                    ? AssetImage('assets/images/default_profile_pic.jpg')
                    : NetworkImage(document.data()['profile_picture']),
              ),
              title: Text(
                document.data()['name'],
              ),
              subtitle: Text(
                document.data()['address'],
              ),
              trailing: IconButton(
                color: kAmaranth,
                icon: Icon(Icons.call),
                onPressed: () {
                  launch("tel://" + document.data()['phone_no']);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEmergencyContact(
                      currentName: document.data()['name'],
                      currentPhone: document.data()['phone_no'],
                      currentAddress: document.data()['address'],
                      currentProfilePicture: document.data()['profile_picture'],
                      flag: 0,
                      docid: document.id,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
