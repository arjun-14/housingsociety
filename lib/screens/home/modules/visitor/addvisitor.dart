import 'package:flutter/material.dart';

class AddVisitor extends StatefulWidget {
  static const String id = 'add_visitor';

  @override
  _AddVisitorState createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor> {
  TimeOfDay selectedTimeIn =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TimeOfDay selectedTimeOut;

  Future selectTimeIn(BuildContext context) async {
    TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTimeIn);
    if (picked != null) {
      setState(() {
        selectedTimeIn = picked;
      });
    }
  }

  Future selectTimeOut(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
    if (picked != null) {
      setState(() {
        selectedTimeOut = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Visitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            ReusableTextField(
              maxlines: null,
              labelText: 'Name',
              prefixIcon: Icon(Icons.perm_identity),
            ),
            ReusableTextField(
              labelText: 'Mobile No',
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.call),
              maxLength: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: ReusableTextField(
                  labelText: 'Wing',
                  prefixIcon: Icon(Icons.apartment),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ReusableTextField(
                    labelText: 'Flat No.',
                  ),
                ),
              ],
            ),
            ReusableTextField(
              labelText: 'Purpose',
              maxlines: null,
              prefixIcon: Icon(Icons.work),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      selectTimeIn(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color(0xFF03DAC5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'In  ' + selectedTimeIn.format(context),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      selectTimeOut(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color(0xFF03DAC5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        selectedTimeOut == null
                            ? Text(
                                'Out  ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Out  ' + selectedTimeOut.format(context),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
        ),
        onPressed: () {},
      ),
    );
  }
}

class ReusableTextField extends StatelessWidget {
  final String labelText;
  final dynamic maxlines;
  final TextInputType keyboardType;
  final String initialValue;
  final Function onTap;
  final Icon prefixIcon;
  final int maxLength;

  ReusableTextField({
    @required this.labelText,
    this.maxlines,
    this.keyboardType,
    this.onTap,
    this.initialValue,
    this.prefixIcon,
    this.maxLength,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxlines,
      keyboardType: keyboardType,
      initialValue: initialValue,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
    );
  }
}
