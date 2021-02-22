import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/notice/addnotice.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class RealTimeNoticeUpdate extends StatefulWidget {
  @override
  _RealTimeNoticeUpdateState createState() => _RealTimeNoticeUpdateState();
}

enum TtsState { playing, stopped, paused, continued }

class _RealTimeNoticeUpdateState extends State<RealTimeNoticeUpdate> {
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  final translator = GoogleTranslator();

  Future _speak(String notice) async {
    print(flutterTts.getLanguages);
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.speak(notice);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  void translate(String input) {
    translator.translate(input, to: 'ml').then((result) => print(result));
  }

  @override
  Widget build(BuildContext context) {
    Query notice = FirebaseFirestore.instance
        .collection('module_notice')
        .orderBy('timestamp', descending: true);
    return StreamBuilder<QuerySnapshot>(
        stream: notice.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Timestamp timestamp = document.data()['timestamp'];
              DateTime dateTime = timestamp.toDate();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNotice(
                          editTitle: document.data()['title'],
                          editNotice: document.data()['notice'],
                          flag: 0,
                          uid: document.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSpaceCadet,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 0, 16),
                                child: Text(
                                  document.data()['title'],
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.translate),
                                onPressed: () {
                                  translate(document.data()['notice']);
                                }),
                            IconButton(
                                icon: Icon(Icons.volume_up),
                                onPressed: () {
                                  _speak(document.data()['notice']);
                                }),
                            IconButton(
                              iconSize: 20,
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                DatabaseService().deleteNotice(document.id);
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            document.data()['notice'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            dateTime.day.toString() +
                                '/' +
                                dateTime.month.toString() +
                                '    ' +
                                dateTime.hour.toString() +
                                ':' +
                                dateTime.minute.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}
