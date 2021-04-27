import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/complaints/realtimecommentsupdate.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  final DatabaseService db = DatabaseService();

  final docid;
  final bool social;
  final String socialusername;
  Comments({this.docid, this.social, this.socialusername});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    String comment;
    var _textController = TextEditingController();
    return Container(
      color: kSpaceCadet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: RealTimeCommentUpdates(
              docid: docid,
              social: social,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    controller: _textController,
                    onChanged: (val) {
                      comment = val;
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.emoji_emotions,
                        ),
                      ),
                      fillColor: kSpaceCadet,
                      filled: true,
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    color: kAmaranth,
                    onPressed: () {
                      _textController.clear();
                      db.addComment(
                          social, docid, user.name, comment, socialusername);
                    },
                    icon: Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
