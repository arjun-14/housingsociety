import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/chat/realtimeUpdate.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  DatabaseService db = DatabaseService();

  String message;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    var _textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: RealtimeChatUpdate(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    controller: _textController,
                    onChanged: (val) {
                      message = val;
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
                      hintText: 'Type a message...',
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
                      db.addMessage(
                        message,
                        user.name,
                        user.email,
                        Timestamp.now(),
                      );
                    },
                    icon: Icon(Icons.send),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            )
          ],
        ),
      ),
    );
  }
}
