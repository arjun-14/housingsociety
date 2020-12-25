import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/voting/dynamicparticipants.dart';

class AddVoting extends StatefulWidget {
  static const String id = 'add_voting';

  @override
  _AddVotingState createState() => _AddVotingState();
}

class _AddVotingState extends State<AddVoting> {
  List<DynamicParticipants> dynamicparticipants = [];

  void addParticpant() {
    setState(() {
      dynamicparticipants.add(DynamicParticipants());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addParticpant(),
        child: Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: dynamicparticipants.length,
          itemBuilder: (context, index) {
            return Column(children: [
              dynamicparticipants[index],
            ]);
          },
        ),
      ),
    );
  }
}
