import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/shared/comments.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/models/user.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/services/auth.dart';

class RealTimeComplaintUpdate extends StatefulWidget {
  final String complaintStatus;
  RealTimeComplaintUpdate({this.complaintStatus});

  @override
  _RealTimeComplaintUpdateState createState() =>
      _RealTimeComplaintUpdateState();
}

class _RealTimeComplaintUpdateState extends State<RealTimeComplaintUpdate> {
  bool liked = false;
  DatabaseService db = DatabaseService();
  Map<String, dynamic> likes;
  dynamic userid = AuthService().userId();
  String complaintstatus;
  String userType;
  CollectionReference<Map<String, dynamic>> moduleComplaintUserLikes =
      FirebaseFirestore.instance.collection('module_complaint_user_likes');
  CollectionReference<Map<String, dynamic>> moduleComplaint =
      FirebaseFirestore.instance.collection('module_complaint');

  @override
  void initState() {
    super.initState();
    getCurrentUSerLikes();
    getuserdata();
  }

  Future getuserdata() async {
    dynamic userdata = await DatabaseService().getuserdata();
    userType = userdata.data()['userType'];
  }

  void getCurrentUSerLikes() async {
    moduleComplaintUserLikes
        .doc(userid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          likes = documentSnapshot.data();
        });
      } else {
        setState(() {
          likes = {};
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    Query<Map<String, dynamic>> notice = FirebaseFirestore.instance
        .collection('module_complaint')
        .orderBy('likes', descending: true)
        .where('status', isEqualTo: widget.complaintStatus);
    return likes == null
        ? Loading()
        : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: notice.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              return ListView(
                children: snapshot.data.docs
                    .map((DocumentSnapshot<Map<String, dynamic>> document) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kSpaceCadet,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 0, 16),
                                  child: Text(
                                    document.data()['username'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              userType == 'admin'
                                  ? TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: kSpaceCadet,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          10.0)),
                                            ),
                                            context: context,
                                            builder: (BuildContext context) {
                                              complaintstatus =
                                                  widget.complaintStatus;
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                        StateSetter setState) =>
                                                    Wrap(
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          RadioListTile(
                                                            title: Text('Open'),
                                                            value: 'open',
                                                            groupValue:
                                                                complaintstatus,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                complaintstatus =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title:
                                                                Text('On Hold'),
                                                            value: 'on hold',
                                                            groupValue:
                                                                complaintstatus,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                complaintstatus =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title:
                                                                Text('Closed'),
                                                            value: 'closed',
                                                            groupValue:
                                                                complaintstatus,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                complaintstatus =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Skip',
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            kAmaranth,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          kAmaranth,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      DatabaseService().updateComplaintStatus(
                                                                          document
                                                                              .id,
                                                                          complaintstatus);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        (document.data()['status'])
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: document.data()['status'] ==
                                                  'open'
                                              ? Colors.green
                                              : document.data()['status'] ==
                                                      'on hold'
                                                  ? Colors.yellow
                                                  : Colors.red,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        (document.data()['status'])
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: document.data()['status'] ==
                                                  'open'
                                              ? Colors.green
                                              : document.data()['status'] ==
                                                      'on hold'
                                                  ? Colors.yellow
                                                  : Colors.red,
                                        ),
                                      ),
                                    ),
                              Visibility(
                                visible: userType == 'admin',
                                child: IconButton(
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  onPressed: () {
                                    db.deleteComplaint(document.id);
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              document.data()['description'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    await db.updateLikes(
                                        moduleComplaint,
                                        moduleComplaintUserLikes,
                                        document.id,
                                        document.data()['likes'],
                                        user.uid);
                                    DocumentSnapshot value =
                                        await moduleComplaintUserLikes
                                            .doc(userid)
                                            .get();
                                    setState(() {
                                      likes = value.data();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.thumb_up,
                                    color: likes.containsKey(document.id)
                                        ? kAmaranth
                                        : Colors.white,
                                  ),
                                  label: Text(
                                    document.data()['likes'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    showBarModalBottomSheet(
                                      context: context,
                                      builder: (context) => Comments(
                                        docid: document.id,
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.comment_outlined,
                                    color: kAmaranth,
                                  ),
                                  label: Text(
                                    'Comment',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            });
  }
}
