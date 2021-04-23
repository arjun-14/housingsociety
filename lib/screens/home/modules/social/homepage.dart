import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';

class HomePageSocial extends StatefulWidget {
  @override
  _HomePageSocialState createState() => _HomePageSocialState();
}

class _HomePageSocialState extends State<HomePageSocial> {
  CollectionReference moduleSocial =
      FirebaseFirestore.instance.collection('module_social');
  String loggedinUserUid = AuthService().userId();
  List<Widget> photos = [];
  Set photosset;
  Map<Timestamp, String> photomap = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moduleSocial
        .doc(loggedinUserUid)
        .collection('following')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
        moduleSocial
            .doc(queryDocumentSnapshot.data()['uid'])
            .collection('photos')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs
              .forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
            photomap[queryDocumentSnapshot.data()['timestamp']] =
                queryDocumentSnapshot.data()['url'];
            setState(() {});
            // photos.add(Image.network(queryDocumentSnapshot.data()['url']));
          });
        });
      });
    }).then((value) {
      List sortedKeys = photomap.keys.toList()..sort();

      for (var i = sortedKeys.length - 1; i >= 0; i--) {
        photos.add(Image.network(photomap[sortedKeys[i]]));
      }
      print(photomap);
    });
    // setState(() {
    //   photos.toSet().toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Column(
            children: photos,
          ),
        ],
      ),
    );
  }
}

// class HomePageSocial extends StatefulWidget {
//   @override
//   _HomePageSocialState createState() => _HomePageSocialState();
// }

// class _HomePageSocialState extends State<HomePageSocial> {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<CurrentUser>(context);
//     CollectionReference moduleSocial =
//         FirebaseFirestore.instance.collection('module_social');
//     Map<Timestamp, String> photomap = {};
//     List<Widget> photos = [];
//     return StreamBuilder<QuerySnapshot>(
//       stream: moduleSocial.snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Loading();
//         }
//         moduleSocial
//             .doc(user.uid)
//             .collection('following')
//             .get()
//             .then((QuerySnapshot querySnapshot) {
//           querySnapshot.docs
//               .forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
//             moduleSocial
//                 .doc(queryDocumentSnapshot.data()['uid'])
//                 .collection('photos')
//                 .get()
//                 .then((QuerySnapshot querySnapshot) {
//               querySnapshot.docs
//                   .forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
//                 photomap[queryDocumentSnapshot.data()['timestamp']] =
//                     queryDocumentSnapshot.data()['url'];
//                 //photos.add(Image.network(queryDocumentSnapshot.data()['url']));
//                 // if (photos.contains(
//                 //     Image.network(queryDocumentSnapshot.data()['url']))) {
//                 //   print('');
//                 // } else {
//                 //   photos
//                 //       .add(Image.network(queryDocumentSnapshot.data()['url']));
//                 // }
//               });
//               var sortedKeys = photomap.keys.toList()..sort();
//               for (var i = 0; i < sortedKeys.length; i++) {
//                 photos.add(Image.network(photomap[sortedKeys[i]]));
//               }
//               print(photos);
//             });
//           });
//         });

//         // return Container();
//         return Container(
//           child: ListView(
//             children: [
//               Column(
//                 children: photos,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
