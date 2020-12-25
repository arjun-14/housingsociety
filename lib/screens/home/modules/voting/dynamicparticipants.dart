import 'package:flutter/material.dart';

class DynamicParticipants extends StatelessWidget {
  final int index;
  DynamicParticipants({this.index});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Participant ' + index.toString(),
      ),
    );
  }
}
