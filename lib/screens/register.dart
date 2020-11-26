import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        visibiltyIconColor = Color(0xFFEB1555);
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
                    'Create an account',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEB1555),
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
                      color: Color(0xFFEB1555),
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
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFEB1555),
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
