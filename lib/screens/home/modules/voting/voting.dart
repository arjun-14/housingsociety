import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/voting/addvoting.dart';

class Voting extends StatelessWidget {
  static const String id = 'voting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddVoting.id);
        },
      ),
    );
  }
}
