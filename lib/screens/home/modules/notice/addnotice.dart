import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:housingsociety/screens/home/modules/notice/notice.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';

class AddNotice extends StatefulWidget {
  static const String id = 'add_notice';
  final String editTitle;
  final String editNotice;
  final int flag;
  final String docid;
  AddNotice({this.editTitle, this.editNotice, this.flag, this.docid});

  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  FocusNode myFocusNode;
  String title = '';
  String notice = '';

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    if (widget.flag == 0) {
      title = widget.editTitle;
      notice = widget.editNotice;
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myFocusNode.requestFocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Notice'),
          actions: [
            Visibility(
              visible: title.trim() != '' && notice.trim() != '',
              child: IconButton(
                icon: Icon(Icons.save),
                color: kAmaranth,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: kOxfordBlue,
                          title: Text('Save as notice or event?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                widget.flag == 0
                                    ? DatabaseService().editNotice(
                                        widget.docid, title, notice, 'notice')
                                    : DatabaseService()
                                        .addNotice(title, notice, 'notice');

                                Navigator.popUntil(
                                    context, ModalRoute.withName(Notice.id));
                              },
                              child: Text('Notice'),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.flag == 0
                                    ? DatabaseService().editNotice(
                                        widget.docid, title, notice, 'event')
                                    : DatabaseService()
                                        .addNotice(title, notice, 'event');

                                Navigator.popUntil(
                                    context, ModalRoute.withName(Notice.id));
                              },
                              child: Text('Event'),
                            ),
                          ],
                        );
                      });
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Column(
                children: [
                  TextFormField(
                    initialValue: widget.flag == 0 ? widget.editTitle : null,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                    ),
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),
                  TextFormField(
                    focusNode: myFocusNode,
                    autofocus: true,
                    initialValue: widget.flag == 0 ? widget.editNotice : null,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Notice',
                    ),
                    onChanged: (val) {
                      setState(() {
                        notice = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
