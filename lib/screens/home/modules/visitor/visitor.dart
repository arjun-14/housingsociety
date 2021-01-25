import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/visitor/addvisitor.dart';
import 'package:housingsociety/screens/home/modules/visitor/realtimevisitorupdate.dart';

class Visitor extends StatelessWidget {
  static const String id = 'visitor';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor History'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddVisitor.id);
        },
      ),
      body: RealTimeVisitorUpdate(),
    );
  }
}
