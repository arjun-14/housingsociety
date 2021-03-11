import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';
import 'package:housingsociety/screens/home/modules/complaints/piechart.dart';
import 'package:housingsociety/screens/home/modules/complaints/realtimecomplaintupdate.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rake/rake.dart';

class Complaint extends StatelessWidget {
  static const String id = 'complaint';

  Widget build(BuildContext context) {
    Map<String, double> keywords = {};
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
        actions: [
          TextButton(
            onPressed: () async {
              keywords = {};
              final rake = Rake();
              await FirebaseFirestore.instance
                  .collection('module_complaint')
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((document) {
                  List documentKeywords =
                      rake.rank(document.data()['description']);
                  for (var keyword in documentKeywords) {
                    if (keywords.containsKey(keyword)) {
                      keywords[keyword] += 1;
                    } else {
                      keywords[keyword] = 1;
                    }
                  }
                });
              });
              keywords.isEmpty
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Text(
                            'There should be atleast one complaint to analyse'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'),
                          )
                        ],
                      ),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PieChartComplaints(
                          dataMap: keywords,
                        ),
                      ),
                    );
              print(keywords);
            },
            child: Text(
              'Analyze',
              style: TextStyle(color: kAmaranth),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddComplaint.id);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: RealTimeComplaintUpdate(),
    );
  }
}
