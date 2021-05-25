import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';
import 'package:provider/provider.dart';

class EditPhoneNumber extends StatefulWidget {
  static const String id = 'edit_profile_number';
  @override
  _EditPhoneNumberState createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  String phoneNumber = '';
  String verificationId;

  // Future<void> verifyPhoneNo() async{

  //   final PhoneVerificationCompleted verified = (PhoneAuthCredential authResult){
  //     print('verification completed');
  //   };
  //   final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException){
  //     print(authException.message);
  //   };

  //   final PhoneCodeSent smsSent = (String verificationId,int forceResendingToken){
  //     this.verificationId = verificationId;
  //   };

  //   final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verificationId){
  //     this.verificationId = verificationId;
  //   };

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+917499722262',
  //     timeout: Duration(seconds: 20,),
  //     verificationCompleted: verified,
  //     verificationFailed: verificationFailed,
  //     codeSent: smsSent,
  //     codeAutoRetrievalTimeout: autoRetrievalTimeout,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update your phone number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              phoneNumber = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Phone Number',
          ),
          keyboardType: TextInputType.number,
        ),
      ),
      floatingActionButton: Visibility(
        visible: phoneNumber.length != 10 ? false : true,
        child: FloatingActionButton(
          child: Icon(
            Icons.save,
          ),
          onPressed: () async {
            await DatabaseService().updatePhoneNumber(user.uid, phoneNumber);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
