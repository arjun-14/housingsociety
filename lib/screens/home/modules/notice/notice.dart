import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/notice/addnotice.dart';

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
          print('click');
          Navigator.pushNamed(context, AddNotice.id);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
