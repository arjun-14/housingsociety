import 'package:flutter/material.dart';

class DynamicParticipants extends StatelessWidget {
  final Function onpressed;
  final TextEditingController controller;

  DynamicParticipants({this.onpressed, this.controller});
  final TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller2,
      onChanged: onpressed,
      decoration: InputDecoration(
        labelText: 'Participant ',
      ),
    );
  }
}
