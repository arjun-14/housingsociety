import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/database.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:provider/provider.dart';

class Health extends StatefulWidget {
  static const String id = 'health';

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  String groupvalue = 'Healthy';

  DatabaseService db = DatabaseService();
  AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
    getInitialstatus();
  }

  void getInitialstatus() async {
    DocumentSnapshot result =
        await db.readIndividualHealthStatus(_auth.userId());
    setState(() {
      groupvalue = result.data()['health'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: Text('Home Quarantined'),
            value: 'Home Quarantined',
            groupValue: groupvalue,
            onChanged: (value) {
              setState(() {
                groupvalue = value;
              });
            },
          ),
          RadioListTile(
            title: Text('Hospitalized'),
            value: 'Hospitalized',
            groupValue: groupvalue,
            onChanged: (value) {
              setState(() {
                groupvalue = value;
              });
            },
          ),
          RadioListTile(
            title: Text('Healthy'),
            value: 'Healthy',
            groupValue: groupvalue,
            onChanged: (value) {
              setState(() {
                groupvalue = value;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kXiketic,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Status',
            icon: Icon(
              Icons.medical_services,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Summary',
            icon: Icon(
              Icons.info,
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            dynamic result = db.addIndividualHealthStatus(user.uid, groupvalue);
            if (result != null) {
              final snackBar = SnackBar(
                backgroundColor: kXiketic,
                duration: Duration(seconds: 1),
                content: Text(
                  'Status saved successfully',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          child: Icon(
            Icons.save,
          ),
        ),
      ),
    );
  }
}
