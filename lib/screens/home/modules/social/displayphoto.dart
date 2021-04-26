import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';

class DisplayPhoto extends StatelessWidget {
  final String username;
  final String profilePicture;
  final String photo;
  final int likes;
  final int comments;
  final String caption;
  final String docid;
  DisplayPhoto({
    this.username,
    this.profilePicture,
    this.photo,
    this.likes,
    this.comments,
    this.caption,
    this.docid,
  });
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    CollectionReference moduleSocialPhotos =
        FirebaseFirestore.instance.collection('module_social_photos');
    CollectionReference moduleSocialPhotosLikes =
        FirebaseFirestore.instance.collection('module_social_photos_likes');
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: ListView(
        children: [
          Image.network(photo),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: kAmaranth,
                  ),
                  onPressed: () {
                    DatabaseService().updateLikes(
                      moduleSocialPhotos,
                      moduleSocialPhotosLikes,
                      docid,
                      likes,
                      user.uid,
                    );
                  }),
              IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: kAmaranth,
                  ),
                  onPressed: () {}),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              likes.toString() + ' likes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                  children: [
                    TextSpan(
                      text: username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '  ' + caption)
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
