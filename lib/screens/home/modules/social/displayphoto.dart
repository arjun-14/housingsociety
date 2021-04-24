import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class DisplayPhoto extends StatelessWidget {
  final String username;
  final String profilePicture;
  final String photo;
  final int likes;
  final int comments;
  final String caption;
  DisplayPhoto(
      {this.username,
      this.profilePicture,
      this.photo,
      this.likes,
      this.comments,
      this.caption});
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {}),
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
