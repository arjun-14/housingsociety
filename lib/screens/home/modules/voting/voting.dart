import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/voting/addvoting.dart';
import 'package:housingsociety/screens/home/modules/voting/realtimevotingupdate.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:polls/polls.dart';

class Voting extends StatelessWidget {
  static const String id = 'voting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              color: kAmaranth,
              onPressed: () {
                Navigator.pushNamed(context, AddVoting.id);
              })
        ],
      ),
      body: RealTimeVotingUpdate(),
    );
  }
}
