import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/admin/residentclassification.dart';

class Residents extends StatelessWidget {
  static const String id = 'residents';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
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
              Tab(
                text: 'Disabled',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          ResidentClassification(
            userType: 'admin',
          ),
          ResidentClassification(
            userType: 'user',
          ),
          ResidentClassification(
            userType: 'disabled',
          )
        ]),
      ),
    );
  }
}
