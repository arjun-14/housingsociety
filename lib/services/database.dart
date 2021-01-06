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
  CollectionReference moduleComplaintUserLikes =
      FirebaseFirestore.instance.collection('module_complaint_user_likes');
  CollectionReference moduleComplaintUserComments =
      FirebaseFirestore.instance.collection('module_complaint_comments');

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

  Future<void> setProfileonRegistration(uid, name, wing, flatno) {
    return userProfile.doc(uid).set(
      {
        'name': name,
        'phone_no': ' ',
        'wing': wing,
        'flatno': flatno,
        'profile_picture': ' ',
      },
    );
  }

  Future<void> updateProfileName(uid, updatedName) {
    userProfile.doc(uid).update({
      'name': updatedName,
    });
    return AuthService().updateDisplayName(updatedName);
  }

  Future<void> updateProfilePicture(uid, profilePicture) {
    userProfile.doc(uid).update({
      'profile_picture': profilePicture,
    });
    return AuthService().updateProfilePicture(profilePicture);
  }

  Future<void> updatePhoneNumber(uid, phoneNo) {
    userProfile.doc(uid).update({
      'phone_no': phoneNo,
    });
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
    moduleComplaint.doc(uid).delete().catchError((e) {
      print(e);
    });

    return moduleComplaintUserComments.doc(uid).delete().catchError((e) {
      print(e);
    });
  }

  Future<dynamic> updateLikes(docuid, likes, useruid) async {
    dynamic result;
    await moduleComplaintUserLikes
        .doc(useruid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      result = (documentSnapshot.data()[docuid]);
      if (result == true) {
        moduleComplaintUserLikes.doc(useruid).update({
          docuid: FieldValue.delete(),
        });
        moduleComplaint.doc(docuid).update({
          'likes': likes - 1,
        }).catchError((e) {
          print(e);
        });
      } else {
        moduleComplaintUserLikes.doc(useruid).update({
          docuid: true,
        });
        moduleComplaint.doc(docuid).update({
          'likes': likes + 1,
        }).catchError((e) {
          print(e);
        });
      }
    });
    return result;
  }

  Future<void> addComment(docid, userName, comment) {
    return moduleComplaintUserComments.doc(docid).collection('comments').add({
      'userName': userName,
      'comment': comment,
      'timestamp': Timestamp.now(),
    });
  }
}

// getCurrentUSerLikes() async {
//   dynamic userid = AuthService().userId();
//   Map<String, dynamic> likes;

//   CollectionReference moduleComplaintUserLikes =
//       FirebaseFirestore.instance.collection('module_complaint_user_likes');

//   await moduleComplaintUserLikes
//       .doc(userid)
//       .get()
//       .then((value) => likes = value.data());
//   // moduleComplaintUserLikes
//   //     .get()
//   //     .then((value) => print(value.data()['asasa']));
//   print(likes);
//   return likes;
// }
