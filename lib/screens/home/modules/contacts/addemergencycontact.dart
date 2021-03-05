import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/contacts/contacts.dart';
import 'package:housingsociety/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:housingsociety/shared/constants.dart';
import 'dart:io';

class AddEmergencyContact extends StatefulWidget {
  static const String id = 'add_emergency_contact';
  final String currentProfilePicture,
      currentName,
      currentPhone,
      currentAddress,
      docid;
  final int flag;
  AddEmergencyContact(
      {this.currentProfilePicture,
      this.currentName,
      this.currentPhone,
      this.currentAddress,
      this.flag,
      this.docid});
  @override
  _AddEmergencyContactState createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  File profileImage;
  String profileImagePath = '';
  final picker = ImagePicker();
  String name = '', phoneNo = '', address = '';
  final formkey = GlobalKey<FormState>();
  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        profileImagePath = pickedFile.path;
      }
    });
    print(pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flag == 0) {
      name = widget.currentName;
      phoneNo = widget.currentPhone;
      address = widget.currentAddress;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (widget.flag == 0 &&
                widget.currentName == name &&
                widget.currentPhone == phoneNo &&
                widget.currentAddress == address) {
              Navigator.pop(context);
            } else if (name == '' && phoneNo == '' && address == '') {
              Navigator.pop(context);
            } else {
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
                        TextButton(
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
                        TextButton(
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
            }
          },
        ),
        title: Text('Create Contact'),
        actions: [
          Visibility(
            visible: true,
            child: TextButton(
              onPressed: () async {
                if (formkey.currentState.validate()) {
                  await DatabaseService().addEmergencyContact(name, phoneNo,
                      address, profileImagePath, widget.flag, widget.docid);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                  color: kAmaranth,
                ),
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
                    backgroundImage: widget.currentProfilePicture != '' &&
                            profileImage == null &&
                            widget.flag == 0
                        ? NetworkImage(widget.currentProfilePicture)
                        : profileImage == null
                            ? AssetImage(
                                'assets/images/default_profile_pic.jpg')
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
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    initialValue: name,
                    validator: (val) {
                      return val.isEmpty ? 'Name cannot be empty' : null;
                    },
                    onChanged: (val) {
                      name = val;

                      print(name);
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: phoneNo,
                  onChanged: (val) {
                    phoneNo = val;
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
                  initialValue: address,
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
