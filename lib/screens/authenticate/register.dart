import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import '../../shared/snackbarpage.dart';

class Register extends StatefulWidget {
  final Function toggle;

  Register({required this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String? _email, _password, name, flatno;
  String wing = '';
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
                            'Create an account',
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
                                name = val;
                              });
                            },
                            validator: (val) {
                              return (val == null || val.isEmpty)
                                  ? 'Name cannot be empty'
                                  : null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) {
                                    wing = val;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Wing',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) {
                                    flatno = val;
                                  },
                                  validator: (val) {
                                    return (val == null || val.isEmpty)
                                        ? 'Enter flat no'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Flat no.',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
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
                              return (val == null || val.isEmpty)
                                  ? 'Enter an email'
                                  : null;
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
                              return (val == null || val.length < 4)
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
                                foregroundColor: kAmaranth,
                              ),
                              onPressed: () async {
                                if (_formkey.currentState?.validate() == true) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth
                                      .createUserWithEmailAndPassword(
                                          _email ?? "",
                                          _password ?? "",
                                          name ?? "",
                                          wing,
                                          flatno ?? "");
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    ShowSnackBar().showSnackBar(
                                      context,
                                      'An error occurred. Please try again',
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
                              'Already have an account?',
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
