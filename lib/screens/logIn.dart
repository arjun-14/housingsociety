import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formkey = GlobalKey<FormState>();
  String _email, _password;
  bool buttonEnabled = false;
  bool obscureText = true;
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
        visibiltyIconColor = kButtonColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                      color: kButtonColor,
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
                    child: RaisedButton(
                      color: kButtonColor,
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          print(_email + ' ' + _password);
                        }
                      },
                      child: Text('Continue'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Create a new account',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: kButtonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
