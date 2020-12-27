import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/services/auth.dart';

class DatabaseService {
  CollectionReference moduleChat =
      FirebaseFirestore.instance.collection('module_chat');
  CollectionReference userProfile =
      FirebaseFirestore.instance.collection('user_profile');
  CollectionReference moduleNotice =
      FirebaseFirestore.instance.collection('module_notice');
  CollectionReference moduleComplaint =
      FirebaseFirestore.instance.collection('module_complaint');

  Future<void> addMessage(message, sender, email, Timestamp timestamp) {
    return moduleChat.add(
      {
        'message': message,
        'sender': sender,
        'email': email,
        'timestamp': timestamp,
      },
    );
  }

  Future<void> setProfileonRegistration(uid, name) {
    return userProfile.doc(uid).set(
      {
        'name': name,
      },
    );
  }

  Future<void> updateProfileName(uid, updatedName) {
    userProfile.doc(uid).set({
      'name': updatedName,
    });
    return AuthService().updateDisplayName(updatedName);
  }

  Future<void> addNotice(title, notice) {
    return moduleNotice.add({
      'title': title,
      'notice': notice,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNotice(uid) {
    return moduleNotice.doc(uid).delete().catchError((e) {
      print(e);
    });
  }

  Future<void> editNotice(uid, title, notice) {
    return moduleNotice.doc(uid).update({
      'title': title,
      'notice': notice,
    });
  }

  Future<void> addComplaint(userName, description, likes) {
    return moduleComplaint.add({
      'username': userName,
      'description': description,
      'likes': likes,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteComplaint(uid) {
    return moduleComplaint.doc(uid).delete().catchError((e) {
      print(e);
    });
  }
}
