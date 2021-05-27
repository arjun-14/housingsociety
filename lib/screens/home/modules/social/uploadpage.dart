import 'dart:io';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/storage.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  static const String id = 'upload_page';
  final String username;
  UploadPage({this.username});
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final StorageService storage = StorageService();
  String caption = '';
  File photo;
  String photoPath;
  final picker = ImagePicker();

  Future getImage(source, uid) async {
    final pickedFile = await picker.getImage(
      source: source,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        photoPath = pickedFile.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    print(widget.username);
    void addPhoto() {
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
                    getImage(ImageSource.camera, user.uid);
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.collections),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    getImage(ImageSource.gallery, user.uid);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New post'),
        actions: [
          Visibility(
            visible: photo != null,
            child: IconButton(
              icon: Icon(
                Icons.done,
                color: kAmaranth,
              ),
              onPressed: () {
                storage.uploadPhoto(photoPath, user.uid, caption,
                    widget.username, user.profilePicture);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            //  Image.file(photo),
            TextField(
              onChanged: (value) {
                caption = value;
              },
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Write a caption',
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: kAmaranth,
              ),
              onPressed: () {
                addPhoto();
              },
            ),
            photo == null
                ? SizedBox(
                    height: 0,
                  )
                : Image.file(photo),
          ],
        ),
      ),
    );
  }
}
