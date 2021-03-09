import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';
import 'package:housingsociety/screens/home/modules/complaints/realtimecomplaintupdate.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rake/rake.dart';

class Complaint extends StatelessWidget {
  static const String id = 'complaint';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
        actions: [
          TextButton(
            onPressed: () {
              final exampleText = "The lift in c-wing is not working.";
              final rake = Rake();
             
              print(rake.rank(exampleText));

            
            },
            child: Text(
              'Analyze',
              style: TextStyle(color: kAmaranth),
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddComplaint.id);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: RealTimeComplaintUpdate(),
    );
  }
}
