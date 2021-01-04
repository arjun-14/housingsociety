import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/profile/editEmail.dart';
import 'package:housingsociety/screens/home/modules/profile/editName.dart';
import 'package:housingsociety/screens/home/modules/profile/editPassword.dart';
import 'package:housingsociety/screens/home/modules/profile/editPhoneNumber.dart';
import 'package:housingsociety/screens/home/modules/profile/reusableprofiletile.dart';
import 'package:housingsociety/services/storage.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  static const String id = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File profileImage;
  final picker = ImagePicker();
  bool loading = false;
  StorageService storage = StorageService();

  Future getImage(source, uid) async {
    final pickedFile = await picker.getImage(source: source);
    String profileImagePath;

    setState(() {
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        profileImagePath = pickedFile.path;
        storage.uploadProfilePicture(profileImagePath, uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    DocumentReference userProfile =
        FirebaseFirestore.instance.collection('user_profile').doc(user.uid);
    return StreamBuilder<DocumentSnapshot>(
        stream: userProfile.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 65.0,
                        //backgroundColor: Colors.white,
                        backgroundImage: user.profilePicture == null
                            ? AssetImage(
                                'assets/images/default_profile_pic.jpg')
                            : NetworkImage(snapshot.data['profile_picture']),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              backgroundColor: kAmaranth,
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: kSpaceCadet,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(15),
                                          ),
                                        ),
                                        child: ListView(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.camera_alt),
                                              title: Text('Choose from Camera'),
                                              onTap: () {
                                                getImage(ImageSource.camera,
                                                    user.uid);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.collections),
                                              title:
                                                  Text('Choose from gallery'),
                                              onTap: () {
                                                getImage(ImageSource.gallery,
                                                    user.uid);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ReusableProfileTile(
                      label: 'Name',
                      //value: AuthService().userName(),
                      value: user.name,
                      onpress: () {
                        Navigator.pushNamed(context, EditName.id);
                      },
                    ),
                    ReusableProfileTile(
                      label: 'Email',
                      value: user.email,
                      onpress: () {
                        Navigator.pushNamed(context, EditEmail.id);
                      },
                    ),
                    ReusableProfileTile(
                      label: 'Phone',
                      value: snapshot.data['phone_no'],
                      onpress: () {
                        Navigator.pushNamed(context, EditPhoneNumber.id);
                      },
                    ),
                    ReusableProfileTile(
                      label: 'Change password',
                      value: ' ',
                      onpress: () {
                        Navigator.pushNamed(context, EditPassword.id);
                      },
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Delete account',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
