import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housingsociety/screens/home/modules/visitor/addvisitor.dart';
import 'package:housingsociety/screens/home/modules/visitor/realtimevisitorupdate.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Visitor extends StatefulWidget {
  static const String id = 'visitor';

  @override
  _VisitorState createState() => _VisitorState();
}

class _VisitorState extends State<Visitor> {
  String userType;
  int pageNumber = 0;
  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  Future getuserdata() async {
    dynamic userdata = await DatabaseService().getuserdata();
    setState(() {
      userType = userdata.data()['userType'];
    });
  }

  // String dropdownValue = 'Clear History';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor History'),
        actions: [
          Visibility(
            visible: userType == 'admin',
            child: PopupMenuButton(
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
                    ]),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: userType == 'admin',
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AddVisitor.id);
          },
        ),
      ),
      body: pageNumber == 0
          ? RealTimeVisitorUpdate()
          : TableCalendar(
              calendarController: CalendarController(),
              startDay: DateTime.utc(2010, 10, 16),
              endDay: DateTime.utc(2030, 3, 14),
              initialSelectedDay: DateTime.now(),
            ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: kOxfordBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    pageNumber = 0;
                  });
                },
                icon: Icon(Icons.ac_unit),
                label: Text('a')),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  pageNumber = 1;
                });
              },
              icon: Icon(
                Icons.calendar_today,
                color: kAmaranth,
              ),
              label: Text(
                'Calendar',
                style: TextStyle(
                  color: kAmaranth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
