import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';
import 'package:housingsociety/screens/home/modules/complaints/realtimecomplaintupdate.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:http/http.dart' as http;

class Complaint extends StatelessWidget {
  static const String id = 'complaint';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
        actions: [
          TextButton(
            onPressed: () async {
              final url = 'https://192.168.0.107/';
              final response = await http.post(url,
                  body: json.encode({
                    'complaint':
                        'electricity is not working. we have water shortage'
                  }));
              print('response' + response.statusCode.toString());
            },
            child: Text(
              'Analyze',
              style: TextStyle(color: kAmaranth),
            ),
          ),
          TextButton(
            onPressed: () async {
              final url = 'https://192.168.0.107/';
              final response = await http.get(url);
              print(json.decode(response.body));
            },
            child: Text(
              'GET',
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
