import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/loading.dart';
import 'package:housingsociety/shared/snackbarpage.dart';

class LogIn extends StatefulWidget {
  final Function toggle;
  LogIn({this.toggle});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String _email, _password;
  bool buttonEnabled = false;
  bool obscureText = true;
  bool loading = false;
  Color visibiltyIconColor = Colors.grey;

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
    return loading == true
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: 300.0,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                _email = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty ? 'Enter an email' : null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email ID',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            obscureText: obscureText,
                            onChanged: (val) {
                              setState(() {
                                _password = val;
                              });
                            },
                            validator: (val) {
                              return val.length < 4
                                  ? 'Password must be minimum of 4 characters'
                                  : null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: visibiltyIconColor,
                                ),
                                onPressed: unHidePassword,
                              ),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kAmaranth,
                              ),
                              // color: kAmaranth,
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.logInWithEmailAndPassword(
                                          _email, _password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    ShowSnackBar().showSnackBar(
                                      context,
                                      'Incorrect email id or password',
                                    );
                                  }
                                }
                              },
                              child: Text('Continue'),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggle();
                            },
                            child: Text(
                              'Create a new account',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: kAmaranth,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
