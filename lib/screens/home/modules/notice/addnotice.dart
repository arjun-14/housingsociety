import 'package:flutter/material.dart';
import 'package:housingsociety/services/database.dart';

class AddNotice extends StatelessWidget {
  static const String id = 'add_notice';
  final String editTitle;
  final String editNotice;
  final int flag;
  final String uid;
  AddNotice({this.editTitle, this.editNotice, this.flag, this.uid});

  @override
  Widget build(BuildContext context) {
    String title = 'Title';
    String notice = 'Notice';
    if (flag == 0) {
      title = editTitle;
      notice = editNotice;
    }
    return Scaffold(
      appBar: AppBar(
          //  title: Text('Add Notice'),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          flag == 0
              ? DatabaseService().editNotice(uid, title, notice)
              : DatabaseService().addNotice(title, notice);
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
            TextFormField(
              initialValue: flag == 0 ? editTitle : null,
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
            TextFormField(
              initialValue: flag == 0 ? editNotice : null,
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
