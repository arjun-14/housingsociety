import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/chat/realtimeUpdate.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';

class Chat extends StatefulWidget {
  static const String id = 'chat';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: TextField(
                      controller: _textController,
                      onChanged: (val) {
                        message = val;
                      },
                      decoration: InputDecoration(
                        // prefixIcon: IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.emoji_emotions,
                        //   ),
                        // ),
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
                        message != null
                            ? db.addMessage(
                                message,
                                user.name ?? AuthService().userName(),
                                user.email,
                                Timestamp.now())
                            : print('null');
                        _textController.clear();
                      },
                      icon: Icon(Icons.send),
                    ),
                  )
                ],
              ),
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
