import 'package:flutter/material.dart';

class Complaint extends StatelessWidget {
  static const String id = 'complaint';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
