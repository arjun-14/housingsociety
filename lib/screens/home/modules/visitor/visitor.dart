import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/visitor/addvisitor.dart';
import 'package:housingsociety/screens/home/modules/visitor/realtimevisitorupdate.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';

class Visitor extends StatefulWidget {
  static const String id = 'visitor';

  @override
  _VisitorState createState() => _VisitorState();
}

class _VisitorState extends State<Visitor> {
  // String dropdownValue = 'Clear History';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor History'),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                if (value == 'Clear History') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: kSpaceCadet,
                        title: Text(
                          'Are you sure you want to clear visitor history?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: kMediumAquamarine,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await DatabaseService().deleteVisitorHistory();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Clear History',
                              style: TextStyle(
                                color: kMediumAquamarine,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Text('Clear History'),
                      value: 'Clear History',
                    ),
                  ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddVisitor.id);
        },
      ),
      body: RealTimeVisitorUpdate(),
    );
  }
}
