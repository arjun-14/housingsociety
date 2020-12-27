import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:housingsociety/shared/constants.dart';

class RealTimeComplaintUpdate extends StatefulWidget {
  @override
  _RealTimeComplaintUpdateState createState() =>
      _RealTimeComplaintUpdateState();
}

class _RealTimeComplaintUpdateState extends State<RealTimeComplaintUpdate> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    Query notice = FirebaseFirestore.instance
        .collection('module_complaint')
        .orderBy('timestamp', descending: true);
    return StreamBuilder<QuerySnapshot>(
        stream: notice.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Timestamp timestamp = document.data()['timestamp'];
              DateTime dateTime = timestamp.toDate();

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kSpaceCadet,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                              child: Text(
                                document.data()['username'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 20,
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              DatabaseService().deleteComplaint(document.id);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          document.data()['description'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton.icon(
                              onPressed: () {
                                setState(() {
                                  liked = !liked;
                                });
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color: liked ? kAmaranth : Colors.white,
                              ),
                              label: Text(document.data()['likes'].toString()),
                            ),
                          ),
                          Expanded(
                            child: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.comment_outlined,
                              ),
                              label: Text('Comment'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Center(
                      //   child: Text(
                      //     dateTime.day.toString() +
                      //         '/' +
                      //         dateTime.month.toString() +
                      //         '    ' +
                      //         dateTime.hour.toString() +
                      //         ':' +
                      //         dateTime.minute.toString(),
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w300,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}
