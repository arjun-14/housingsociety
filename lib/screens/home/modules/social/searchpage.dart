import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/social/defaultprofilepage.dart';
import 'package:housingsociety/screens/home/modules/social/userprofilepage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List queryResultSet = [];
  List tempSearchStore = [];
  CollectionReference moduleSocial =
      FirebaseFirestore.instance.collection('module_social');

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
        setState(() {});
        // print(queryResultSet);
        // setState(() {
        //   tempSearchStore.add(queryResultSet);
        // });
        //print(tempSearchStore);
      });
    } else {
      print(queryResultSet);
      setState(() {
        tempSearchStore = [];
      });

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
            children: tempSearchStore.map((element) {
              return ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return UserProfilePage(
                      uid: element['uid'],
                      username: element['username'],
                    );
                  }));
                },
                leading: CircleAvatar(
                  backgroundImage: element['profile_picture'] == ''
                      ? AssetImage('assets/images/default_profile_pic.jpg')
                      : NetworkImage(element['profile_picture']),
                ),
                title: Text(element['username']),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}
