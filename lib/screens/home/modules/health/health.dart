import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class Health extends StatefulWidget {
  static const String id = 'health';

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  String groupvalue = 'Healthy';

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
