import 'package:flutter/material.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:emoji_picker/emoji_picker.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.white,
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Form(
                    child: TextFormField(
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
                ),
                Expanded(
                  child: IconButton(
                    color: kAmaranth,
                    onPressed: () {
                      print('button');
                      db.addMessage(message, user.email);
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
