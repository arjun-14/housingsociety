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
                        title: Text(
                            'Are you sure you want to clear visitor history?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await DatabaseService().deleteVisitorHistory();
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          )
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
          // DropdownButton(
          //   // value: dropdownValue,
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //   ),
          //   underline: Container(
          //     color: kXiketic,
          //   ),
          //   items: [
          //     DropdownMenuItem(
          //       value: 'Clear History',
          //       child: Text('Clear History'),
          //       onTap: () {
          //         Navigator.pop(context);
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return AlertDialog(
          //               title: Text(
          //                   'Are you sure you want to clear visitor history?'),
          //               actions: [
          //                 TextButton(
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: Text('Yes'),
          //                 )
          //               ],
          //             );
          //           },
          //         );
          //       },
          //     ),
          // ],

          // ),
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
