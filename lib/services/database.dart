import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference moduleChat =
      FirebaseFirestore.instance.collection('module_chat');
  CollectionReference userProfile =
      FirebaseFirestore.instance.collection('user_profile');

  Future<void> addMessage(message, sender, email, Timestamp timestamp) {
    return moduleChat.add(
      {
        'message': message,
        'sender': sender,
        'email': email,
        'timestamp': timestamp
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
}
