import 'package:flutter/material.dart';

class AddNotice extends StatelessWidget {
  static const String id = 'add_notice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notice'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('clicked');
        },
        child: Icon(
          Icons.save,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextField(
              maxLines: null,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
            ),
            TextField(
              maxLines: null,
              style: TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Notice',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
