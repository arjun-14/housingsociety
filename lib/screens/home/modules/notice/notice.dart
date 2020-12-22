import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  static const String id = 'notice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('clicked');
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
