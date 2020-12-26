import 'package:flutter/material.dart';

class DynamicParticipants extends StatefulWidget {
  final int index;
  DynamicParticipants({this.index});

  @override
  _DynamicParticipantsState createState() => _DynamicParticipantsState();
}

class _DynamicParticipantsState extends State<DynamicParticipants> {
  String temp;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        setState(() {
          temp = val;
        });
        print(temp);
      },
      decoration: InputDecoration(
        labelText: 'Participant ' + widget.index.toString(),
      ),
    );
  }
}
