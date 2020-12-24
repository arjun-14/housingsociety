import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:housingsociety/services/database.dart';

class AddNotice extends StatefulWidget {
  static const String id = 'add_notice';
  final String editTitle;
  final String editNotice;
  final int flag;
  final String uid;
  AddNotice({this.editTitle, this.editNotice, this.flag, this.uid});

  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Title';
    String notice = 'Notice';
    if (widget.flag == 0) {
      title = widget.editTitle;
      notice = widget.editNotice;
    }
    return GestureDetector(
      onTap: () {
        myFocusNode.requestFocus();
      },
      child: Scaffold(
        appBar: AppBar(
            //  title: Text('Add Notice'),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.flag == 0
                ? DatabaseService().editNotice(widget.uid, title, notice)
                : DatabaseService().addNotice(title, notice);
            Navigator.pop(context);
          },
          child: Icon(
            Icons.save,
          ),
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
                      title = val;
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
                      notice = val;
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
