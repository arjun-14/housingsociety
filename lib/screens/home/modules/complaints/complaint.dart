import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';
import 'package:housingsociety/screens/home/modules/complaints/realtimecomplaintupdate.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/loading.dart';

class Complaint extends StatelessWidget {
  static const String id = 'complaint';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddComplaint.id);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: RealTimeComplaintUpdate(),
    );
  }
}

//  Map<String, dynamic> likes;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUSerLikes();
//   }

//   void getCurrentUSerLikes() async {
//     dynamic userid = AuthService().userId();

//     CollectionReference moduleComplaintUserLikes =
//         FirebaseFirestore.instance.collection('module_complaint_user_likes');

//     DocumentSnapshot value = await moduleComplaintUserLikes.doc(userid).get();
//     setState(() {
//       likes = value.data();
//     });

//     moduleComplaintUserLikes
//         .get()
//         .then((value) => print(value.data()['asasa']));
//     print(likes);
//   }
