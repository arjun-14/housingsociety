import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'dart:io';

import 'package:housingsociety/services/database.dart';

class StorageService {
  DatabaseService db = DatabaseService();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadProfilePicture(String filepath, uid) async {
    File file = File(filepath);
    try {
      await storage.ref('profile_picture/$uid.jpg').putFile(file);
      String downloadURL =
          await storage.ref('profile_picture/$uid.jpg').getDownloadURL();
      db.updateProfilePicture(uid, downloadURL);
      print(downloadURL);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> addEmergencyContactPhoto(String filepath, docid) async {
    File file = File(filepath);
    try {
      await storage.ref('emergency_contact/$docid').putFile(file);
      String downloadURL =
          await storage.ref('emergency_contact/$docid').getDownloadURL();
      db.updateEmergencyContact(downloadURL, docid);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
