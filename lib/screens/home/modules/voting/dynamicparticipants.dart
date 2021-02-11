import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class DynamicParticipants extends StatelessWidget {
  final int index;
  final Function onpressed;
  final TextEditingController controller;
  // final bool visibility;
  DynamicParticipants({this.index, this.onpressed, this.controller});
  final TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String temp;

    return TextFormField(
      controller: controller2,
      onChanged: onpressed,
      decoration: InputDecoration(
        labelText: 'Participant ' + index.toString(),
        suffixIcon: IconButton(
          onPressed: () {
            print(controller2.text);
          },
          icon: Icon(
            Icons.remove_circle_outline,
            color: kAmaranth,
          ),
        ),
      ),
    );
  }
}
