import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:housingsociety/screens/home/modules/voting/dynamicparticipants.dart';

class AddVoting extends StatefulWidget {
  static const String id = 'add_voting';

  @override
  _AddVotingState createState() => _AddVotingState();
}

class _AddVotingState extends State<AddVoting> {
  List<DynamicParticipants> dynamicparticipants = [
    DynamicParticipants(
      index: 1,
    ),
    DynamicParticipants(
      index: 2,
    )
  ];
  ScrollController _scrollController = ScrollController();

  void addParticpant() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            dynamicparticipants.add(
                DynamicParticipants(index: dynamicparticipants.length + 1));
          });
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          controller: _scrollController,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: dynamicparticipants.length,
              itemBuilder: (context, index) {
                return dynamicparticipants[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}
