import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:housingsociety/screens/home/modules/voting/dynamicparticipants.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';

class AddVoting extends StatefulWidget {
  static const String id = 'add_voting';

  @override
  _AddVotingState createState() => _AddVotingState();
}

class _AddVotingState extends State<AddVoting> {
  String title = '';
  Map<String, int> participants = {};
  List<DynamicParticipants> dynamicparticipants = [
    DynamicParticipants(),
    DynamicParticipants()
  ];
  ScrollController _scrollController = ScrollController();

  Map<String, int> collectParticipantsName() {
    participants.clear();
    var participant;
    for (participant = 0;
        participant < dynamicparticipants.length;
        participant++) {
      if (dynamicparticipants[participant].controller.text != null &&
          dynamicparticipants[participant].controller.text != '') {
        participants[dynamicparticipants[participant].controller.text] = 0;
        // participants.add(dynamicparticipants[participant].controller.text);
      }
    }

    return participants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Participants'),
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              onPressed: title == ''
                  ? null
                  : () {
                      participants = collectParticipantsName();
                      if (participants.length < 2) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'There must be atleast two participants',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: kOxfordBlue,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        DatabaseService().addVoting(title, participants);
                        Navigator.pop(context);
                      }
                    },
              icon: Icon(
                Icons.done,
                color: title == '' ? Colors.grey : kAmaranth,
              ),
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
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
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
                          color: dynamicparticipants.length < 3
                              ? Colors.grey
                              : kAmaranth,
                        ),
                        onPressed: dynamicparticipants.length < 3
                            ? null
                            : () {
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
