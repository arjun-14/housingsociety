import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/chat/chat.dart';
import 'package:housingsociety/screens/home/modules/complaints/complaint.dart';
import 'package:housingsociety/screens/home/modules/contacts/contacts.dart';
import 'package:housingsociety/screens/home/modules/health/health.dart';
import 'package:housingsociety/screens/home/modules/notice/notice.dart';
import 'package:housingsociety/screens/home/modules/profile/profile.dart';
import 'package:housingsociety/screens/home/modules/social/wrappersocial.dart';
import 'package:housingsociety/screens/home/modules/visitor/visitor.dart';
import 'package:housingsociety/screens/home/modules/voting/voting.dart';
import 'package:housingsociety/screens/home/reusableCard.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String userType;

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getuserdata() async {
    await DatabaseService().getuserdata().then((value) {
      setState(() {
        userType = value.data()['userType'];
      });
    });
  }

  Future checkConnectivity() async {
    bool connectivity;
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    connectivity = connectivityResult == ConnectivityResult.none ? false : true;
    return connectivity;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Profile.id);
              },
              icon: Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: userType == 'disabled'
            ? Center(
                child: Text(
                'Your account is disabled.',
                style: TextStyle(fontSize: 20),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ReusableCard(
                          icon: Icons.message,
                          text: 'Chat',
                          onpress: () {
                            Navigator.pushNamed(context, Chat.id);
                          },
                        ),
                        ReusableCard(
                          icon: Icons.announcement,
                          text: 'Notice & Events',
                          onpress: () {
                            Navigator.pushNamed(context, Notice.id);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ReusableCard(
                          icon: Icons.support_agent,
                          text: 'Complaint',
                          onpress: () {
                            Navigator.pushNamed(context, Complaint.id);
                          },
                        ),
                        ReusableCard(
                          icon: Icons.how_to_vote,
                          text: 'Voting',
                          onpress: () {
                            Navigator.pushNamed(context, Voting.id);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ReusableCard(
                          icon: Icons.contacts,
                          text: 'Contacts',
                          onpress: () {
                            Navigator.pushNamed(context, Contacts.id);
                          },
                        ),
                        ReusableCard(
                          icon: Icons.group,
                          text: 'Social Media',
                          onpress: () async {
                            var connectivity = await checkConnectivity();
                            connectivity == true
                                ? Navigator.pushNamed(context, WrapperSocial.id)
                                : showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                            'No Internet connection. Please try again'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Okay'),
                                          )
                                        ],
                                      );
                                    });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ReusableCard(
                          icon: Icons.medical_services,
                          text: 'Health',
                          onpress: () {
                            Navigator.pushNamed(context, Health.id);
                          },
                        ),
                        ReusableCard(
                          icon: Icons.face,
                          text: 'Visitor',
                          onpress: () {
                            Navigator.pushNamed(context, Visitor.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
