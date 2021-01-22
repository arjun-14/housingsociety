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
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile No.',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Flat No.',
              ),
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Purpose',
              ),
            )
          ],
        ),
      ),
    );
  }
}
