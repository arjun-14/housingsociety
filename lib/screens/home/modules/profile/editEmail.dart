import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:housingsociety/shared/snackbarpage.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/shared/constants.dart';

class EditEmail extends StatefulWidget {
  static const String id = 'edit_email';
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  String updatedEmail = '';
  String password = '';
  bool obscureText = true;
  Color visibiltyIconColor = Colors.grey;
  bool loading = false;

  void unHidePassword() {
    setState(() {
      obscureText = !obscureText;
    });
    if (obscureText == true) {
      setState(() {
        visibiltyIconColor = Colors.grey;
      });
    } else {
      setState(() {
        visibiltyIconColor = kAmaranth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return loading == true
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit your email'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: user.email,
                    decoration: InputDecoration(
                      labelText: 'New Email ID',
                    ),
                    onChanged: (value) {
                      setState(() {
                        updatedEmail = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: unHidePassword,
                        icon: Icon(
                          Icons.visibility,
                          color: visibiltyIconColor,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: Visibility(
              visible: (updatedEmail != user.email && updatedEmail != '') &&
                      password != '' &&
                      password.length > 4
                  ? true
                  : false,
              child: FloatingActionButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  dynamic result =
                      await AuthService().updateEmail(updatedEmail, password);
                  setState(() {
                    loading = false;
                  });
                  print(result);
                  if (result == null) {
                    ShowSnackBar().showSnackBar(context,
                        'An error occured. Please try again', Colors.white);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Icon(Icons.save),
              ),
            ),
          );
  }
}
