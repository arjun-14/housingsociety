import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class ShowSnackBar {
  void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
        backgroundColor: kOxfordBlue,
      ),
    );
  }
}
