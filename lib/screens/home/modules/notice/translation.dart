import 'package:flutter/material.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:translator/translator.dart';

class Translate extends StatefulWidget {
  final String title;
  final String notice;
  final String outputLanguage;
  Translate({this.title, this.notice, this.outputLanguage});
  @override
  _TranslateState createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  String translatedTitle = '';
  String translatedNotice = '';
  final translator = GoogleTranslator();
  final Map<String, String> outputLanguageCode = {
    'Bengali': 'bn',
    'English': 'en',
    'Gujarati': 'gu',
    'Hindi': 'hi',
    'Kannada': 'kn',
    'Malayalam': 'ml',
    'Marathi': 'mr',
    'Punjabi': 'pa',
    'Sindhi': 'sd',
    'Tamil': 'ta',
    'Telugu': 'te'
  };
  @override
  void initState() {
    super.initState();
    translate(widget.title, widget.notice, widget.outputLanguage);
  }

  void translate(String title, String notice, String outputLanguage) async {
    await translator
        .translate(title, to: outputLanguageCode[outputLanguage])
        .then((result) {
      setState(() {
        translatedTitle = result.toString();
      });

      print(title);
    });
    await translator
        .translate(notice, to: outputLanguageCode[outputLanguage])
        .then((result) {
      setState(() {
        translatedNotice = result.toString();
      });

      print(notice);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (translatedTitle == '' && translatedNotice == '') {
      return Loading();
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(translatedTitle),
            Text(translatedNotice),
          ],
        ),
      ),
    );
  }
}
