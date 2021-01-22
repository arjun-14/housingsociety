import 'package:flutter/material.dart';

class AddVisitor extends StatelessWidget {
  static const String id = 'add_visitor';
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
            ),
            ReusableTextField(
              labelText: 'Mobile No',
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                    child: ReusableTextField(
                  labelText: 'Wing',
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
  ReusableTextField(
      {@required this.labelText, this.maxlines, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxlines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
