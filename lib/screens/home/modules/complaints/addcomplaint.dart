import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';

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
        visible: (description != null) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            DatabaseService()
                .addComplaint(AuthService().userName(), description, 0);
            Navigator.pop(context);
          },
          child: Icon(
            Icons.save,
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
                  autofocus: true,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Describe your issue ...',
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 40,
                //   child: RaisedButton(
                //     color: kAmaranth,
                //     onPressed: () {
                //       DatabaseService().addComplaint(title, description);
                //       Navigator.pop(context);
                //     },
                //     child: Text('Lodge Complaint'),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
