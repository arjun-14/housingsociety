import 'dart:io';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/social/profilepage.dart';
import 'package:housingsociety/services/storage.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  File photo;
  final picker = ImagePicker();
  StorageService storage = StorageService();
  Future getImage(source, uid) async {
    final pickedFile = await picker.getImage(source: source);
    String photoPath;

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        photoPath = pickedFile.path;
        storage.uploadPhoto(photoPath, uid);
        //storage.uploadProfilePicture(profileImagePath, uid);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _appbartitleoptions = [
    Text('Home'),
    Text('Search'),
    Text('Activity'),
    Text('Profile')
  ];

  List<Widget> _widgetoptions = [
    Text('a'),
    Text('b'),
    Text('c'),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

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
        title: _appbartitleoptions.elementAt(_selectedIndex),
        actions: [
          Visibility(
            visible: _selectedIndex == 3,
            child: IconButton(
              icon: Icon(Icons.add_box),
              color: kAmaranth,
              onPressed: () {
                addPhoto();
              },
            ),
          ),
        ],
      ),
      body: _widgetoptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kOxfordBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: kOxfordBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Like',
            backgroundColor: kOxfordBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: kOxfordBlue,
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        onTap: _onItemTapped,
        selectedItemColor: kAmaranth,
      ),
    );
  }
}
