import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/profile/editEmail.dart';
import 'package:housingsociety/screens/home/modules/profile/editName.dart';
import 'package:housingsociety/screens/home/modules/profile/editPassword.dart';
import 'package:housingsociety/screens/home/modules/profile/reusableprofiletile.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              radius: 65.0,
              backgroundColor: Colors.white,
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
                                      getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(Icons.collections),
                                    title: Text('Choose from gallery'),
                                    onTap: () {
                                      getImage(ImageSource.gallery);
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
    );
  }
}
