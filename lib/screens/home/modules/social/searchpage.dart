import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/social/otherusersprofilepage.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List queryResultSet = [];
  List tempSearchStore = [];
  CollectionReference moduleSocial =
      FirebaseFirestore.instance.collection('module_social');
  String loggedinUserUid = AuthService().userId();

  void initiateSearch(String value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    String lowercaseValue = value.toLowerCase();

    if (queryResultSet.length == 0 && value.length == 1) {
      searchByUserName(value).then((QuerySnapshot querySnapshot) {
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          queryResultSet.add(querySnapshot.docs[i].data());
          tempSearchStore.add(querySnapshot.docs[i].data());
        }
        tempSearchStore
            .removeWhere((element) => element['uid'] == loggedinUserUid);
        setState(() {});
      });
    } else {
      print(queryResultSet);
      setState(() {
        tempSearchStore = [];
      });
      queryResultSet
          .removeWhere((element) => element['uid'] == loggedinUserUid);
      queryResultSet.forEach((element) {
        if (element['username'].startsWith(lowercaseValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
      // print(tempSearchStore);
    }
  }

  Future<QuerySnapshot> searchByUserName(String searchField) {
    return moduleSocial
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toLowerCase())
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser>(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                initiateSearch(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'Search',
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            children: tempSearchStore.map((user) {
              return ListTile(
                onTap: () {
                  moduleSocial
                      .doc(currentUser.uid)
                      .collection('following')
                      .doc(user['uid'])
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    bool following;
                    if (documentSnapshot.exists) {
                      following = true;
                    } else {
                      following = false;
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return UserProfilePage(
                        uid: user['uid'],
                        username: user['username'],
                        following: following,
                      );
                    }));
                  });
                },
                leading: CircleAvatar(
                  backgroundImage: user['profile_picture'] == ''
                      ? AssetImage('assets/images/default_profile_pic.jpg')
                      : NetworkImage(user['profile_picture']),
                ),
                title: Text(user['username']),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}
