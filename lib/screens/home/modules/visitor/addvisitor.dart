import 'package:flutter/material.dart';

class AddVisitor extends StatefulWidget {
  static const String id = 'add_visitor';

  @override
  _AddVisitorState createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor> {
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  Future selectTime(BuildContext context) async {
    TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        print(selectedTime);
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
        child: Column(
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
            // Row(
            //   children: [
            //     Expanded(
            //       child: ReusableTextField(
            //         keyboardType: TextInputType.datetime,
            //         labelText: 'In',
            //         initialValue: selectedTime.hour.toString() +
            //             ' : ' +
            //             selectedTime.minute.toString(),
            //         onTap: () {
            //           selectTime(context);
            //         },
            //         prefixIcon: Icon(Icons.access_time),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: ReusableTextField(
            //         keyboardType: TextInputType.datetime,
            //         labelText: 'Out',
            //         onTap: () {
            //           selectTime(context);
            //         },
            //         prefixIcon: Icon(Icons.time_to_leave),
            //       ),
            //     ),
            //   ],
            // ),
            // TextButton(
            //   onPressed: () {
            //     selectTime(context);
            //   },
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.access_time,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         'In  ' +
            //             selectedTime.hour.toString() +
            //             ' : ' +
            //             selectedTime.minute.toString(),
            //       ),
            //     ],
            //   ),
            // ),
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
  ReusableTextField(
      {@required this.labelText,
      this.maxlines,
      this.keyboardType,
      this.onTap,
      this.initialValue,
      this.prefixIcon,
      this.maxLength});
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
