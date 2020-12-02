import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String message;
  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {
                            print('clicked');
                          },
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
