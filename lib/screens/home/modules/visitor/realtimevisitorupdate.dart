import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/visitor/addvisitor.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class RealTimeVisitorUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query moduleVisitor = FirebaseFirestore.instance
        .collection('module_visitor')
        .orderBy('timestamp', descending: true);
    return StreamBuilder<QuerySnapshot>(
      stream: moduleVisitor.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong.');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  color: kSpaceCadet,
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      leading: Icon(
                        Icons.perm_identity,
                        color: kMediumAquamarine,
                      ),
                      title: Text(document.data()['name']),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddVisitor(
                                name: document.data()['name'],
                                wing: document.data()['wing'],
                                flatno: document.data()['flatno'],
                                purpose: document.data()['purpose'],
                                mobileNo: document.data()['mobileNo'],
                                selectedTimeIn: TimeOfDay(
                                  hour: ((document.data()['inTime'])
                                                  .split(':')[1])
                                              .split(' ')[1] ==
                                          'PM'
                                      ? 12 +
                                          int.parse((document.data()['inTime'])
                                              .split(':')[0])
                                      : int.parse((document.data()['inTime'])
                                          .split(':')[0]),
                                  minute: int.parse(((document.data()['inTime'])
                                          .split(':')[1])
                                      .split(' ')[0]),
                                ),
                                flag: 0,
                                docid: document.id,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      leading: Icon(
                        Icons.call,
                        color: kMediumAquamarine,
                      ),
                      title: Text(document.data()['mobileNo']),
                      onTap: () {
                        launch("tel://" + document.data()['mobileNo']);
                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      leading: Icon(
                        Icons.apartment,
                        color: kMediumAquamarine,
                      ),
                      title: Text(document.data()['wing'] +
                          ' ' +
                          document.data()['flatno']),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      leading: Icon(
                        Icons.work,
                        color: kMediumAquamarine,
                      ),
                      title: Text(document.data()['purpose']),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              Icons.access_time,
                              color: kMediumAquamarine,
                            ),
                            title: Text('In:  ' + document.data()['inTime']),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              Icons.access_time,
                              color: kMediumAquamarine,
                            ),
                            title: Text('Out:  ' + document.data()['outTime']),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      document.data()['timestamp'].toDate().day.toString() +
                          ' / ' +
                          document
                              .data()['timestamp']
                              .toDate()
                              .month
                              .toString(),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
