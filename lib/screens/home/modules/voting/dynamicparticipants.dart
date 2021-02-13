import 'package:flutter/material.dart';

class DynamicParticipants extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Participant ',
      ),
    );
  }
}
