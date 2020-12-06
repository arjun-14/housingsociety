import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class RealtimeChatUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    Query users = FirebaseFirestore.instance
        .collection('module_chat')
        .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return ListView(
          reverse: true,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: document.data()['email'] == user.email
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      document.data()['sender'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Material(
                    color: kAmaranth,
                    elevation: 5.0,
                    borderRadius: document.data()['email'] == user.email
                        ? BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        document.data()['message'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// Ink(
//     decoration: BoxDecoration(
//       color: kSpaceCadet,
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: ListTile(
//       // tileColor: kSpaceCadet,
//       title: Text(
//         document.data()['sender'],
//         style: TextStyle(fontSize: 15),
//       ),
//       subtitle: Text(
//         document.data()['message'],
//         style: TextStyle(fontSize: 17),
//       ),
//     ),
// ),
