import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'dart:io';

class StorageService {
  firebase_storage.FirebaseStorage storageProfilePicture =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadProfilePicture(String filepath, uid) async {
    File file = File(filepath);
    try {
      await storageProfilePicture.ref('profile_picture/$uid.jpg').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
