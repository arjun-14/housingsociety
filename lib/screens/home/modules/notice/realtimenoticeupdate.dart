import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/notice/addnotice.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:housingsociety/screens/home/modules/notice/reusableflatbutton.dart';

class RealTimeNoticeUpdate extends StatefulWidget {
  final String noticeType;
  RealTimeNoticeUpdate({this.noticeType});
  @override
  _RealTimeNoticeUpdateState createState() => _RealTimeNoticeUpdateState();
}

enum TtsState { playing, stopped, paused, continued }

class _RealTimeNoticeUpdateState extends State<RealTimeNoticeUpdate> {
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  String currentPlayingDocId;
  String userType;
  Future _speak(String notice, String docid) async {
    print(flutterTts.getLanguages);
    await flutterTts.setLanguage("hi-IN");
    var result = await flutterTts.speak(notice);
    if (result == 1)
      setState(() {
        ttsState = TtsState.playing;
        currentPlayingDocId = docid;
      });
    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  Future getuserdata() async {
    dynamic userdata = await DatabaseService().getuserdata();
    userType = userdata.data()['userType'];
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> moduleNotice = FirebaseFirestore.instance
        .collection('module_notice')
        .orderBy('timestamp', descending: true)
        .where('type', isEqualTo: widget.noticeType);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: moduleNotice.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data.docs
                .map((DocumentSnapshot<Map<String, dynamic>> document) {
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
                          docid: document.id,
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
                            Visibility(
                              visible: ttsState == TtsState.playing &&
                                  currentPlayingDocId == document.id,
                              child: IconButton(
                                iconSize: 25,
                                color: kAmaranth,
                                icon: Icon(Icons.stop),
                                onPressed: () {
                                  _stop();
                                },
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              color: kAmaranth,
                              icon: Icon(
                                Icons.more_vert,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Wrap(
                                        children: [
                                          Container(
                                            color: kOxfordBlue,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child: Wrap(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        kOxfordBlue,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          8.0),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Bengali',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'English',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Gujarati',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Hindi',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Kannada',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Malayalam',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Marathi',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Punjabi',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Sindhi',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Tamil',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                      ReusableFlatButton(
                                                                        outputLanguage:
                                                                            'Telugu',
                                                                        title: document
                                                                            .data()['title'],
                                                                        notice:
                                                                            document.data()['notice'],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  leading: Icon(
                                                    Icons.translate,
                                                    color: kAmaranth,
                                                  ),
                                                  title: Text(
                                                    'Translate',
                                                    style: TextStyle(
                                                      color: kAmaranth,
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: true,
                                                  child: ListTile(
                                                    onTap: () {
                                                      _speak(
                                                          document.data()[
                                                                  'title'] +
                                                              '  ' +
                                                              document.data()[
                                                                  'notice'],
                                                          document.id);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Icon(
                                                      Icons.volume_up,
                                                      color: kAmaranth,
                                                    ),
                                                    title: Text(
                                                      'Text-to-speech',
                                                      style: TextStyle(
                                                        color: kAmaranth,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: userType == 'admin',
                                                  child: ListTile(
                                                    onTap: () {
                                                      DatabaseService()
                                                          .deleteNotice(
                                                              document.id);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Icon(
                                                      Icons.delete,
                                                      color: kAmaranth,
                                                    ),
                                                    title: Text(
                                                      'Delete Notice',
                                                      style: TextStyle(
                                                        color: kAmaranth,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    });
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
