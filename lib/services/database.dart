import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/storage.dart';

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
  CollectionReference moduleContatcsEmergencyContact =
      FirebaseFirestore.instance.collection('module_contacts_emergency');
  CollectionReference moduleVisitor =
      FirebaseFirestore.instance.collection('module_visitor');
  CollectionReference moduleVoting =
      FirebaseFirestore.instance.collection('module_voting');

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
        'phone_no': '',
        'wing': wing,
        'flatno': flatno,
        'profile_picture': '',
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
    return userProfile.doc(uid).update({
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
      'status': 'open',
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> updateComplaintStatus(docid, status) {
    return moduleComplaint.doc(docid).update({
      'status': status,
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
      if (documentSnapshot.exists) {
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
      } else {
        moduleComplaintUserLikes.doc(useruid).set({
          docuid: true,
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

  Future<void> addEmergencyContact(
      name, phoneNo, address, profilePicture, flag, docid) async {
    if (flag == 0) {
      if (profilePicture == '') {
        await moduleContatcsEmergencyContact.doc(docid).update({
          'name': name,
          'phone_no': phoneNo,
          'address': address,
        });
      } else {
        await moduleContatcsEmergencyContact.doc(docid).update({
          'name': name,
          'phone_no': phoneNo,
          'address': address,
          'profile_picture': '',
        });
        StorageService storage = StorageService();
        storage.addEmergencyContactPhoto(profilePicture, docid);
      }
    } else {
      DocumentReference result = await moduleContatcsEmergencyContact.add({
        'name': name,
        'phone_no': phoneNo,
        'address': address,
        'profile_picture': '',
      });

      StorageService storage = StorageService();
      storage.addEmergencyContactPhoto(profilePicture, result.id);
    }
  }

  Future<void> updateEmergencyContact(profilePicture, docid) {
    return moduleContatcsEmergencyContact.doc(docid).update({
      'profile_picture': profilePicture,
    });
  }

  void addIndividualHealthStatus(uid, status) {
    if (status == 'Healthy') {
      userProfile.doc(uid).update({
        'health': FieldValue.delete(),
      });
    } else {
      userProfile.doc(uid).update({
        'health': status,
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<DocumentSnapshot> readIndividualHealthStatus(uid) {
    return userProfile.doc(uid).get();
  }

  Future addVisitor(name, mobileNo, wing, flatno, purpose, inTime, outTime) {
    return moduleVisitor.add({
      'name': name,
      'mobileNo': mobileNo,
      'wing': wing,
      'flatno': flatno,
      'purpose': purpose,
      'inTime': inTime,
      'outTime': outTime,
      'timestamp': DateTime.now()
    });
  }

  Future updateVisitor(
      name, mobileNo, wing, flatno, purpose, inTime, outTime, docid) {
    return moduleVisitor.doc(docid).update({
      'name': name,
      'mobileNo': mobileNo,
      'wing': wing,
      'flatno': flatno,
      'purpose': purpose,
      'inTime': inTime,
      'outTime': outTime,
    });
  }

  Future deleteVisitor(docid) {
    return moduleVisitor.doc(docid).delete();
  }

  Future deleteVisitorHistory() {
    return moduleVisitor.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future addVoting(String title, Map participants) {
    return moduleVoting.add({
      'title': title,
      'participants': participants,
      'timestamp': Timestamp.now(),
    });
  }

  Future voteForCandidate(
      String docid, String participant, int vote, String uid) {
    moduleVoting.doc(docid).set({
      'participants': {participant: vote}
    }, SetOptions(merge: true));

    return moduleVoting.doc(docid).set({
      'users': {uid: true}
    }, SetOptions(merge: true));
  }

  Future deleteVote(String docid) {
    return moduleVoting.doc(docid).delete();
  }
}
