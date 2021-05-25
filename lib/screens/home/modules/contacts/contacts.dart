import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/screens/home/modules/contacts/addemergencycontact.dart';
import 'package:housingsociety/screens/home/modules/contacts/emergencycontacts.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:housingsociety/services/database.dart';

class Contacts extends StatefulWidget {
  static const String id = 'contacts';

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  int _selectedIndex = 0;
  String userType;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  Future getuserdata() async {
    dynamic userdata = await DatabaseService().getuserdata();
    userType = userdata.data()['userType'];
    print(userType);
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> userProfile =
        FirebaseFirestore.instance.collection('user_profile').orderBy('name');
    //  .where('phone_no', isNotEqualTo: '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          Visibility(
            visible: _selectedIndex == 0 ? false : true,
            child: Visibility(
              visible: userType == 'admin',
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddEmergencyContact.id,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: userProfile.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }
                return ListView(
                  children: snapshot.data.docs
                      .map((DocumentSnapshot<Map<String, dynamic>> document) {
                    return document.data()['phone_no'] == ''
                        ? SizedBox(
                            height: 0,
                          )
                        : ListTile(
                            leading: CircleAvatar(
                              backgroundImage: document
                                          .data()['profile_picture'] ==
                                      ''
                                  ? AssetImage(
                                      'assets/images/default_profile_pic.jpg')
                                  : NetworkImage(
                                      document.data()['profile_picture']),
                            ),
                            title: Text(
                              document.data()['name'],
                            ),
                            subtitle: Text(
                              document.data()['wing'] +
                                  ' ' +
                                  document.data()['flatno'],
                            ),
                            trailing: IconButton(
                              color: kAmaranth,
                              icon: Icon(Icons.call),
                              onPressed: () {
                                launch("tel://" + document.data()['phone_no']);
                              },
                            ),
                          );
                  }).toList(),
                );
              },
            )
          : EmergencyContacts(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kXiketic,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
            ),
            label: 'Emergency',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
