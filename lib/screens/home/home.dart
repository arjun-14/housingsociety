import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/chat/chat.dart';
import 'package:housingsociety/screens/home/reusableCard.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                print(_auth.userName());
                print(user.name);
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
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF1D1E33),
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chat(),
                        ),
                      );
                      print('clikced');
                    },
                  ),
                  ReusableCard(
                    icon: Icons.announcement,
                    text: 'Notice',
                    onpress: () {
                      final snackbar = SnackBar(
                        content: Text('test'),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);
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
                      print('clikced');
                    },
                  ),
                  ReusableCard(
                    icon: Icons.local_mall,
                    text: 'Market',
                    onpress: () {
                      print('clikced');
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
                      print('clikced');
                    },
                  ),
                  ReusableCard(
                    icon: Icons.group,
                    text: 'Social Media',
                    onpress: () {
                      print('clikced');
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
                      print('clikced');
                    },
                  ),
                  ReusableCard(
                    icon: Icons.face,
                    text: 'Visitor',
                    onpress: () {
                      print('clikced');
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
