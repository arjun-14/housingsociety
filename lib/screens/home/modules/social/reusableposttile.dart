import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/shared/comments.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ReusablePostDisplayTile extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> document;
  final Map likes;
  ReusablePostDisplayTile({this.document, this.likes});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    CollectionReference<Map<String, dynamic>> moduleSocialPhotos =
        FirebaseFirestore.instance.collection('module_social_photos');
    CollectionReference<Map<String, dynamic>> moduleSocialPhotosLikes =
        FirebaseFirestore.instance.collection('module_social_photos_likes');

    void likepost() {
      likes.containsKey(document.id)
          ? likes[document.id] = !likes[document.id]
          : likes[document.id] = true;

      DatabaseService().updateLikes(
        moduleSocialPhotos,
        moduleSocialPhotosLikes,
        document.id,
        document.data()['likes'],
        user.uid,
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: document.data()['profile_picture'] == null
                  ? AssetImage('assets/images/default_profile_pic.jpg')
                  : NetworkImage(
                      document.data()['profile_picture'],
                    ),
            ),
            title: Text(document.data()['username']),
          ),
          GestureDetector(
            onDoubleTap: () {
              likepost();
            },
            child: Image.network(
              document.data()['url'],
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : Loading();
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    likes.containsKey(document.id)
                        ? likes[document.id] == true
                            ? Icons.favorite
                            : Icons.favorite_border
                        : Icons.favorite_border,
                    color: kAmaranth,
                  ),
                  onPressed: () {
                    likepost();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: kAmaranth,
                  ),
                  onPressed: () {
                    showBarModalBottomSheet(
                        context: context,
                        builder: (context) => Comments(
                              social: true,
                              docid: document.id,
                            ));
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              document.data()['likes'].toString() + ' likes',
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
                      text: document.data()['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '  ' + document.data()['caption'])
                  ]),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
