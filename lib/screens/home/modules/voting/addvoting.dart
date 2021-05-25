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
  List timer;
  DateTime dateAndTime;
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

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: kOxfordBlue,
        duration: Duration(seconds: 1),
      ),
    );
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
                        showSnackBar(
                            context, 'There must be atleast two participants');
                      } else if (dateAndTime == null) {
                        showSnackBar(context, 'Set a timer');
                      } else {
                        DatabaseService()
                            .addVoting(title, participants, dateAndTime);
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
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      DateTime date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(2100),
                      );

                      if (date != null) {
                        TimeOfDay time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute));
                        if (time != null) {
                          DateTime now = DateTime.now();

                          dateAndTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );

                          print(dateAndTime);

                          Duration difference = dateAndTime.difference(now);
                          print(difference.toString().split(':'));

                          if (difference.isNegative) {
                            final snackBar = SnackBar(
                                backgroundColor: kSpaceCadet,
                                content: Text(
                                  'Timer cannot be set for time that has already passed.',
                                  style: TextStyle(color: Colors.white),
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            setState(() {
                              timer = difference.toString().split(':');
                            });
                          }
                        }
                      }
                    },
                    child: Text(
                      'Set Timer',
                      style: TextStyle(
                        color: kAmaranth,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: timer != null,
                  child: Expanded(
                    child: timer != null
                        ? Center(
                            child: Text(
                              timer[0] +
                                  'h ' +
                                  timer[1] +
                                  'm ' +
                                  (timer[2]).split('.')[0] +
                                  's ',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
