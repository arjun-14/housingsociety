import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/admin/residentclassification.dart';

class Residents extends StatelessWidget {
  static const String id = 'residents';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Residents'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Admins',
              ),
              Tab(
                text: 'Residents',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          ResidentClassification(
            userType: 'admin',
          ),
          ResidentClassification(
            userType: 'resident',
          ),
        ]),
      ),
    );
  }
}
