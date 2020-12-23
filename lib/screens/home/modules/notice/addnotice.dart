import 'package:flutter/material.dart';
import 'package:housingsociety/services/database.dart';

class AddNotice extends StatelessWidget {
  static const String id = 'add_notice';
  String title = 'Title';
  String notice = 'Notice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notice'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DatabaseService().addNotice(title, notice);
          Navigator.pop(context);
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
              onChanged: (val) {
                title = val;
              },
            ),
            TextField(
              maxLines: null,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Notice',
              ),
              onChanged: (val) {
                notice = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}
