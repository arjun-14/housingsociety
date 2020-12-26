import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';

class Complaint extends StatelessWidget {
  static const String id = 'complaint';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddComplaint.id);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
