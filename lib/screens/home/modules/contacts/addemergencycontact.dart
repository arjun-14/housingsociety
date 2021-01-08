import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/contacts/contacts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:housingsociety/shared/constants.dart';
import 'dart:io';

class AddEmergencyContact extends StatefulWidget {
  static const String id = 'add_emergency_contact';

  @override
  _AddEmergencyContactState createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  File profileImage;
  final picker = ImagePicker();
  String name, phoneno, address;

  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source);
    String profileImagePath;

    setState(() {
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        profileImagePath = pickedFile.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: kSpaceCadet,
                    title: Text(
                      'Your changes have not been saved',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Contacts.id),
                          );
                        },
                        child: Text(
                          'Discard',
                          style: TextStyle(
                            color: kAmaranth,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: kAmaranth,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
        title: Text('Create Contact'),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                color: kAmaranth,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: profileImage == null
                        ? AssetImage('assets/images/default_profile_pic.jpg')
                        : FileImage(profileImage),
                    radius: 65,
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
                            Icons.add_a_photo_sharp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    name = val;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.perm_identity,
                    ),
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    phoneno = val;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.call,
                    ),
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    address = val;
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                    ),
                    labelText: 'Address',
                    border: OutlineInputBorder(),
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
