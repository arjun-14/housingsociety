import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference moduleChat =
      FirebaseFirestore.instance.collection('module_chat');

  Future<void> addMessage(message, sender) {
    return moduleChat.add(
      {'message': message, 'sender': sender},
    );
  }

  void messageStream() async {
    await for (var snapshot in moduleChat.snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
}
