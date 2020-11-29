import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/reusableCard.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/models/user.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
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
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  icon: Icons.message,
                  text: 'Chat',
                  onpress: () {
                    print('clikced');
                  },
                ),
                ReusableCard(
                  icon: Icons.announcement,
                  text: 'Notice',
                  onpress: () {
                    print('clikced');
                  },
                ),
                ReusableCard(
                  icon: Icons.medical_services,
                  text: 'Health',
                  onpress: () {
                    print('clikced');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  icon: Icons.message,
                  text: 'Complaint',
                  onpress: () {
                    print('clikced');
                  },
                ),
                ReusableCard(
                  icon: Icons.message,
                  text: 'Market',
                  onpress: () {
                    print('clikced');
                  },
                ),
                ReusableCard(
                  icon: Icons.message,
                  text: 'Visitor',
                  onpress: () {
                    print('clikced');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
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
                ReusableCard(
                  icon: Icons.message,
                  text: 'Events',
                  onpress: () {
                    print('clikced');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
