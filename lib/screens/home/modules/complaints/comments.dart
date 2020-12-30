import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class Comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String comment;
    var _textController = TextEditingController();
    return Container(
      color: kSpaceCadet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
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
