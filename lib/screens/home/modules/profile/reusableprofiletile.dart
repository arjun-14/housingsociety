import 'package:flutter/material.dart';

class ReusableProfileTile extends StatelessWidget {
  final String label;
  final String value;
  final Function onpress;
  ReusableProfileTile({this.label, this.value, this.onpress});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
