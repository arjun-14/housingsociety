import 'package:flutter/material.dart';

class AddComplaint extends StatefulWidget {
  static const String id = 'add_complaint';

  @override
  _AddComplaintState createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Complaint'),
      ),
      floatingActionButton: Visibility(
        visible: (title != null && description != null) ? true : false,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Column(
              children: [
                TextFormField(
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
                    setState(() {
                      title = val;
                    });
                  },
                ),
                TextFormField(
                  autofocus: true,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
