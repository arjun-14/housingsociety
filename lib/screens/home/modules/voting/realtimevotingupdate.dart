import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/shared/loading.dart';

class RealTimeVotingUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query moduleVoting = FirebaseFirestore.instance
        .collection('module_voting')
        .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: moduleVoting.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            var participant;
            List<Widget> participants = [
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Cast your vote for the position: '),
                  TextSpan(
                    text: document.data()['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(text: ' below'),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
            ];
            for (participant = 0;
                participant < (document.data()['participants']).length;
                participant++) {
              participants.add(
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:
                            Text(document.data()['participants'][participant])),
                  ),
                ),
              );
            }

            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: participants,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
