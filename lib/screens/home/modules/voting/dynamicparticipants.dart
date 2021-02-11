import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class DynamicParticipants extends StatelessWidget {
  final int index;
  final Function onpressed;

  // final bool visibility;
  DynamicParticipants({this.index, this.onpressed});

  @override
  Widget build(BuildContext context) {
    String temp;
    return TextFormField(
      onChanged: onpressed,
      decoration: InputDecoration(
        labelText: 'Participant ' + index.toString(),
        // suffixIcon: IconButton(
        //   onPressed: onpressed,
        //   icon: Icon(
        //     Icons.remove_circle_outline,
        //     color: kAmaranth,
        //   ),
        // ),
      ),
    );
  }
}
