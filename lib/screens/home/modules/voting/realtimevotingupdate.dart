import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class RealTimeVotingUpdate extends StatefulWidget {
  @override
  _RealTimeVotingUpdateState createState() => _RealTimeVotingUpdateState();
}

class _RealTimeVotingUpdateState extends State<RealTimeVotingUpdate> {
  dynamic result;
  int totalVotes = 0;
  String userType;

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  Future getuserdata() async {
    dynamic userdata = await DatabaseService().getuserdata();
    userType = userdata.data()['userType'];
    print(userType);
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> moduleVoting = FirebaseFirestore.instance
        .collection('module_voting')
        .orderBy('timestamp', descending: true);
    Timestamp timestamp = Timestamp.now();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: moduleVoting.snapshots(),
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
            // voteStatus(document.id);
            List<Widget> participants = [
              Row(
                children: [
                  Expanded(
                    child: RichText(
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
                  ),
                  Visibility(
                    visible: userType == 'admin',
                    child: GestureDetector(
                      onTap: () {
                        DatabaseService().deleteVote(document.id);
                      },
                      child: Tooltip(
                        message: 'Delete',
                        child: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ];

            (document.data()['participants']).forEach((participant, vote) {
              try {
                result = document.data()['users'][AuthService().userId()];
                totalVotes = document.data()['users'].length;
              } on NoSuchMethodError {
                totalVotes = 0;
                result = null;
              }
              participants.add(
                timestamp.compareTo(document.data()['timer']) > 0 ||
                        result == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            LinearPercentIndicator(
                              animation: true,
                              percent:
                                  totalVotes != 0 ? vote / totalVotes : 0.0,
                              lineHeight: 15.0,
                              trailing: totalVotes != 0
                                  ? Text((vote / totalVotes * 100)
                                      .toStringAsFixed(2))
                                  : Text('0.00'),
                              //  leading: Text(participant),
                              progressColor: kAmaranth,
                              center: Text(
                                participant,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        'Confirm vote for candidate: ' +
                                            participant),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          DatabaseService().voteForCandidate(
                                            document.id,
                                            participant,
                                            vote + 1,
                                            AuthService().userId(),
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(participant),
                          ),
                        ),
                      ),
              );
            });
            participants.add(
              totalVotes < 2
                  ? Row(
                      children: [
                        Expanded(child: Text(totalVotes.toString() + ' vote')),
                        document.data()['timer'] != null
                            ? Text(
                                'Ends on ${DateFormat('dd/MM/yy H:m').format((document.data()['timer']).toDate())}')
                            : SizedBox(
                                width: 0,
                              )
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(child: Text(totalVotes.toString() + ' votes')),
                        document.data()['timer'] != null
                            ? Text(
                                'Ends on ${DateFormat('dd/M/yy H:m').format((document.data()['timer']).toDate())}')
                            : SizedBox(
                                width: 0,
                              )
                      ],
                    ),
            );

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onLongPress: () {
                  print('hello');
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceIn,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kOxfordBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: participants,
                    ),
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
