import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class DynamicParticipants extends StatelessWidget {
  final int index;

  // final bool visibility;
  DynamicParticipants({this.index});

  @override
  Widget build(BuildContext context) {
    String temp;
    return TextField(
      onChanged: (val) {
        temp = val;
        // print(temp);
      },
      decoration: InputDecoration(
        labelText: 'Participant ' + index.toString(),
        // suffixIcon: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.remove_circle_outline,
        //     color: kAmaranth,
        //   ),
        // ),
      ),
    );
  }
}
