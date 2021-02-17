import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

            (document.data()['participants']).forEach((participant, vote) {
              participants.add(
                  // LinearPercentIndicator(
                  //   animation: true,
                  //   percent: 0.2,
                  //   lineHeight: 15.0,
                  //   leading: Text(document.data()['participants'][participant]),
                  //   progressColor: kAmaranth,
                  //   center: Text(
                  //     '50%',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(participant),
                  ),
                ),
              ));
            });

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kOxfordBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: participants,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
