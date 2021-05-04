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
import 'package:housingsociety/screens/home/admin/residents.dart';
import 'package:housingsociety/screens/home/reusableCard.dart';
import 'package:housingsociety/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                print(AuthService().userName());
              },
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF1D1E33),
                ),
                child: Text(
                  'Society',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Chat.id);
                },
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Profile.id);
                },
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Residents.id);
                },
                title: Text('Manage Residents'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                    onpress: () {
                      Navigator.pushNamed(context, WrapperSocial.id);
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
