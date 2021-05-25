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
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: userType == 'admin' && pageNumber == 0,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AddVisitor.id);
          },
        ),
      ),
      body: RealTimeVisitorUpdate(),
      bottomNavigationBar: Visibility(
        visible: false,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: kOxfordBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ReusbaleBottomNavBarChild(
                pageNumber: 0,
                onpressed: () {
                  setState(() {
                    pageNumber = 0;
                  });
                },
                iconData: Icons.note,
                label: 'Log',
                color: pageNumber == 0 ? kAmaranth : Colors.white,
              ),
              ReusbaleBottomNavBarChild(
                pageNumber: 1,
                onpressed: () {
                  setState(() {
                    pageNumber = 1;
                  });
                },
                iconData: Icons.calendar_today,
                label: 'Calendar',
                color: pageNumber == 1 ? kAmaranth : Colors.white,
              ),
              ReusbaleBottomNavBarChild(
                pageNumber: 2,
                onpressed: () {
                  setState(() {
                    pageNumber = 2;
                  });
                },
                iconData: Icons.add,
                label: 'Housekeeper',
                color: pageNumber == 2 ? kAmaranth : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusbaleBottomNavBarChild extends StatelessWidget {
  ReusbaleBottomNavBarChild(
      {this.pageNumber, this.onpressed, this.iconData, this.label, this.color});

  final int pageNumber;
  final IconData iconData;
  final Function onpressed;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onpressed,
        icon: Icon(
          iconData,
          color: color,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: color,
          ),
        ));
  }
}
