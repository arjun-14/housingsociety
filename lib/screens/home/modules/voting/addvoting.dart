import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:housingsociety/screens/home/modules/voting/dynamicparticipants.dart';
import 'package:housingsociety/shared/constants.dart';

class AddVoting extends StatefulWidget {
  static const String id = 'add_voting';

  @override
  _AddVotingState createState() => _AddVotingState();
}

class _AddVotingState extends State<AddVoting> {
  List<String> participantsname = [];
  List<DynamicParticipants> dynamicparticipants = [
    DynamicParticipants(),
    DynamicParticipants()
  ];
  ScrollController _scrollController = ScrollController();

  List<String> collectParticipantsName() {
    participantsname.clear();
    var participant;
    for (participant = 0;
        participant < dynamicparticipants.length;
        participant++) {
      if (dynamicparticipants[participant].controller2.text != '') {
        participantsname.add(dynamicparticipants[participant].controller2.text);
      }
    }

    return participantsname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Participants'),
        actions: [
          IconButton(
            onPressed: () {
              collectParticipantsName();
              print(participantsname);
            },
            icon: Icon(
              Icons.done,
              color: kAmaranth,
            ),
          ),
        ],
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
                return Row(
                  children: [
                    Expanded(
                      child: dynamicparticipants[index],
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: kAmaranth,
                        ),
                        onPressed: () {
                          setState(() {
                            dynamicparticipants.removeAt(index);
                          });
                        }),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: kAmaranth,
                  ),
                  onPressed: () {
                    setState(() {
                      dynamicparticipants.add(
                        DynamicParticipants(),
                      );
                    });
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
