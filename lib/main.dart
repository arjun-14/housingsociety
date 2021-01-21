import 'package:flutter/material.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';
import 'package:housingsociety/screens/home/modules/complaints/complaint.dart';
import 'package:housingsociety/screens/home/modules/contacts/addemergencycontact.dart';
import 'package:housingsociety/screens/home/modules/contacts/contacts.dart';
import 'package:housingsociety/screens/home/modules/health/health.dart';
import 'package:housingsociety/screens/home/modules/health/quarantinesummary.dart';
import 'package:housingsociety/screens/home/modules/notice/addnotice.dart';
import 'package:housingsociety/screens/home/modules/notice/notice.dart';
import 'package:housingsociety/screens/home/modules/profile/editEmail.dart';
import 'package:housingsociety/screens/home/modules/profile/editName.dart';
import 'package:housingsociety/screens/home/modules/profile/editPassword.dart';
import 'package:housingsociety/screens/home/modules/profile/editPhoneNumber.dart';
import 'package:housingsociety/screens/home/modules/profile/profile.dart';
import 'package:housingsociety/screens/home/modules/visitor/visitor.dart';
import 'package:housingsociety/screens/home/modules/voting/addvoting.dart';
import 'package:housingsociety/screens/home/modules/voting/voting.dart';
import 'package:housingsociety/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/screens/home/modules/chat/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        home: Wrapper(),
        routes: {
          Chat.id: (context) => Chat(),
          Profile.id: (context) => Profile(),
          EditName.id: (context) => EditName(),
          EditEmail.id: (context) => EditEmail(),
          EditPhoneNumber.id: (context) => EditPhoneNumber(),
          EditPassword.id: (context) => EditPassword(),
          Notice.id: (context) => Notice(),
          AddNotice.id: (context) => AddNotice(),
          Voting.id: (context) => Voting(),
          AddVoting.id: (context) => AddVoting(),
          Complaint.id: (context) => Complaint(),
          AddComplaint.id: (context) => AddComplaint(),
          Contacts.id: (context) => Contacts(),
          AddEmergencyContact.id: (context) => AddEmergencyContact(),
          Health.id: (context) => Health(),
          QuarantineSummary.id: (context) => QuarantineSummary(),
          Visitor.id: (context) => Visitor(),
        },
      ),
    );
  }
}
