import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/profile/profile.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:housingsociety/shared/snackbarpage.dart';

class EditPassword extends StatefulWidget {
  static const String id = 'edit_password';
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String currentPassword = '';
  String updatedPassword = '';
  String updatedPasswordReEntered = '';
  bool obscureTextCurrent = true;
  bool obscureTextUpdated = true;
  bool obscureTextupdatedReEntered = true;
  bool loading = false;
  Color visibiltyIconColorCurrent = Colors.grey;
  Color visibiltyIconColorUpdated = Colors.grey;
  Color visibiltyIconColorUpdatedReEntered = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: loading == true
          ? Loading()
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        obscureText: obscureTextCurrent,
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureTextCurrent = !obscureTextCurrent;
                                visibiltyIconColorCurrent = obscureTextCurrent
                                    ? Colors.grey
                                    : kAmaranth;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                              color: visibiltyIconColorCurrent,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentPassword = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        obscureText: obscureTextUpdated,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureTextUpdated = !obscureTextUpdated;
                                visibiltyIconColorUpdated = obscureTextUpdated
                                    ? Colors.grey
                                    : kAmaranth;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                              color: visibiltyIconColorUpdated,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            updatedPassword = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        obscureText: obscureTextupdatedReEntered,
                        decoration: InputDecoration(
                          labelText: 'Confirm new password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureTextupdatedReEntered =
                                    !obscureTextupdatedReEntered;
                                visibiltyIconColorUpdatedReEntered =
                                    obscureTextupdatedReEntered
                                        ? Colors.grey
                                        : kAmaranth;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                              color: visibiltyIconColorUpdatedReEntered,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            updatedPasswordReEntered = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: Visibility(
        visible: currentPassword != '' &&
                updatedPassword != '' &&
                updatedPasswordReEntered != ''
            ? true
            : false,
        child: Builder(
          builder: (BuildContext context) => FloatingActionButton(
            onPressed: () async {
              if (updatedPassword != updatedPasswordReEntered) {
                ShowSnackBar().showSnackBar(context, 'passwords do not match');
              } else if (updatedPassword.length < 4) {
                ShowSnackBar().showSnackBar(
                    context, 'Password must be atleast 4 charachters long');
              } else {
                setState(() {
                  loading = true;
                });
                dynamic result = await AuthService()
                    .updatePassword(currentPassword, updatedPassword);
                setState(() {
                  loading = false;
                });
                if (result == 'Password updated successfully') {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      elevation: 50,
                      backgroundColor: kSpaceCadet,
                      title: Text(
                        'Password updated successfully',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(Profile.id),
                            );
                          },
                          child: Text(
                            'Okay',
                            style: TextStyle(),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  ShowSnackBar().showSnackBar(context, result.toString());
                }
              }
            },
            backgroundColor: kAmaranth,
            child: Icon(
              Icons.save,
            ),
          ),
        ),
      ),
    );
  }
}
