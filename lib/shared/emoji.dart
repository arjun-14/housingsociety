import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_picker.dart';

class Emoji extends StatefulWidget {
  @override
  EmojiState createState() => new EmojiState();
}

class EmojiState extends State<Emoji> {
  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      rows: 3,
      columns: 7,
      recommendKeywords: ["racing", "horse"],
      numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        print(emoji);
      },
    );
  }
}
