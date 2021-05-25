import 'package:flutter/material.dart';
import 'package:housingsociety/screens/home/modules/complaints/addcomplaint.dart';
import 'package:housingsociety/screens/home/modules/complaints/complaint.dart';
import 'package:housingsociety/screens/home/modules/contacts/addemergencycontact.dart';
import 'package:housingsociety/screens/home/modules/contacts/contacts.dart';
import 'package:housingsociety/screens/home/modules/health/health.dart';
import 'package:housingsociety/screens/home/modules/health/quarantinesummary.dart';
import 'package:housingsociety/screens/home/modules/notice/addnotice.dart';
import 'package:housingsociety/screens/home/modules/notice/notice.dart';
import 'package:housingsociety/screens/home/modules/notice/translation.dart';
import 'package:housingsociety/screens/home/modules/profile/editEmail.dart';
import 'package:housingsociety/screens/home/modules/profile/editName.dart';
import 'package:housingsociety/screens/home/modules/profile/editPassword.dart';
import 'package:housingsociety/screens/home/modules/profile/editPhoneNumber.dart';
import 'package:housingsociety/screens/home/modules/profile/editflat.dart';
import 'package:housingsociety/screens/home/modules/profile/profile.dart';
import 'package:housingsociety/screens/home/modules/social/wrappersocial.dart';
import 'package:housingsociety/screens/home/modules/visitor/addvisitor.dart';
import 'package:housingsociety/screens/home/modules/visitor/visitor.dart';
import 'package:housingsociety/screens/home/modules/voting/addvoting.dart';
import 'package:housingsociety/screens/home/modules/voting/voting.dart';
import 'package:housingsociety/screens/home/modules/chat/chat.dart';
import 'package:housingsociety/screens/home/admin/residents.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  Chat.id: (context) => Chat(),
  Profile.id: (context) => Profile(),
  EditName.id: (context) => EditName(),
  EditEmail.id: (context) => EditEmail(),
  EditPhoneNumber.id: (context) => EditPhoneNumber(),
  EditPassword.id: (context) => EditPassword(),
  EditFlat.id: (context) => EditFlat(),
  Notice.id: (context) => Notice(),
  AddNotice.id: (context) => AddNotice(),
  Translate.id: (context) => Translate(),
  Voting.id: (context) => Voting(),
  AddVoting.id: (context) => AddVoting(),
  Complaint.id: (context) => Complaint(),
  AddComplaint.id: (context) => AddComplaint(),
  Contacts.id: (context) => Contacts(),
  AddEmergencyContact.id: (context) => AddEmergencyContact(),
  Health.id: (context) => Health(),
  QuarantineSummary.id: (context) => QuarantineSummary(),
  Visitor.id: (context) => Visitor(),
  AddVisitor.id: (context) => AddVisitor(),
  Residents.id: (context) => Residents(),
  WrapperSocial.id: (context) => WrapperSocial(),
};
