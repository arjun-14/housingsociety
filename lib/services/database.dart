import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/services/storage.dart';

class DatabaseService {
  CollectionReference<Map<String, dynamic>> moduleChat =
      FirebaseFirestore.instance.collection('module_chat');
  CollectionReference<Map<String, dynamic>> userProfile =
      FirebaseFirestore.instance.collection('user_profile');
  CollectionReference<Map<String, dynamic>> moduleNotice =
      FirebaseFirestore.instance.collection('module_notice');
  CollectionReference<Map<String, dynamic>> moduleComplaint =
      FirebaseFirestore.instance.collection('module_complaint');
  CollectionReference<Map<String, dynamic>> moduleComplaintUserLikes =
      FirebaseFirestore.instance.collection('module_complaint_user_likes');
  CollectionReference<Map<String, dynamic>> moduleComplaintUserComments =
      FirebaseFirestore.instance.collection('module_complaint_comments');
  CollectionReference<Map<String, dynamic>> moduleContatcsEmergencyContact =
      FirebaseFirestore.instance.collection('module_contacts_emergency');
  CollectionReference<Map<String, dynamic>> moduleVisitor =
      FirebaseFirestore.instance.collection('module_visitor');
  CollectionReference<Map<String, dynamic>> moduleVoting =
      FirebaseFirestore.instance.collection('module_voting');
  CollectionReference<Map<String, dynamic>> moduleSocial =
      FirebaseFirestore.instance.collection('module_social');
  CollectionReference<Map<String, dynamic>> moduleSocialUserNames =
      FirebaseFirestore.instance.collection('module_social_usernames');
  CollectionReference<Map<String, dynamic>> moduleSocialPhotos =
      FirebaseFirestore.instance.collection('module_social_photos');
  CollectionReference<Map<String, dynamic>> moduleSocialPhotosLikes =
      FirebaseFirestore.instance.collection('module_social_photos_likes');
  CollectionReference<Map<String, dynamic>> moduleSocialPhotosComments =
      FirebaseFirestore.instance.collection('module_social_photos_comments');

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
    userProfile.get().then((QuerySnapshot querySnapshot) {
      String userType;
      userType = querySnapshot.docs.length > 0 ? 'user' : 'admin';
      userProfile.doc(uid).set(
        {
          'name': name,
          'phone_no': '',
          'wing': wing,
          'flatno': flatno,
          'profile_picture': '',
          'userType': userType,
        },
      );
    });

    return moduleSocial.doc(uid).set({
      'profile_picture': '',
      'posts': 0,
      'followers': 0,
      'following': 0,
      'username': '',
      'searchKey': '',
      'uid': uid,
    });
  }

  Future<void> updateProfileName(uid, updatedName) {
    userProfile.doc(uid).update({
      'name': updatedName,
    });
    return AuthService().updateDisplayName(updatedName);
  }

  Future<void> updateFlatNo(String docid, String wing, String flatno) {
    return userProfile.doc(docid).update({
      'wing': wing,
      'flatno': flatno,
    });
  }

  Future<void> updateProfilePicture(uid, profilePicture) {
    moduleSocial.doc(uid).update({
      'profile_picture': profilePicture,
    });
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

  Future<void> addNotice(String title, String notice, String type) {
    return moduleNotice.add({
      'title': title,
      'notice': notice,
      'type': type,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNotice(uid) {
    return moduleNotice.doc(uid).delete().catchError((e) {
      print(e);
    });
  }

  Future<void> editNotice(docid, title, notice, String type) {
    return moduleNotice.doc(docid).update({
      'title': title,
      'notice': notice,
      'type': type,
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

  Future<void> deleteComplaint(docid) {
    moduleComplaint.doc(docid).delete().catchError((e) {
      print(e);
    });

    moduleComplaintUserComments
        .where('docid', isEqualTo: docid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
        queryDocumentSnapshot.reference.delete();
      });
    });

    return moduleComplaintUserLikes.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
        queryDocumentSnapshot.reference.update({
          docid: FieldValue.delete(),
        });
      });
    });
  }

  Future<dynamic> updateLikes(
      CollectionReference<Map<String, dynamic>> moduleName,
      CollectionReference<Map<String, dynamic>> moduleLikesName,
      docuid,
      likes,
      useruid) async {
    dynamic result;
    await moduleLikesName
        .doc(useruid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        result = (documentSnapshot.data()[docuid]);
        if (result == true) {
          moduleLikesName.doc(useruid).update({
            docuid: FieldValue.delete(),
          });
          moduleName.doc(docuid).update({
            'likes': likes - 1,
          }).catchError((e) {
            print(e);
          });
        } else {
          moduleLikesName.doc(useruid).update({
            docuid: true,
          });
          moduleName.doc(docuid).update({
            'likes': likes + 1,
          }).catchError((e) {
            print(e);
          });
        }
      } else {
        moduleLikesName.doc(useruid).set({
          docuid: true,
        });
        moduleName.doc(docuid).update({
          'likes': likes + 1,
        }).catchError((e) {
          print(e);
        });
      }
    });
    return result;
  }

  Future<void> addComment(
      bool social, docid, userName, comment, socialusername) {
    if (social == true) {
      moduleSocialPhotosComments.add({
        'docid': docid,
        'userName': socialusername,
        'comment': comment,
        'timestamp': Timestamp.now(),
      });
    } else {
      moduleComplaintUserComments.add({
        'docid': docid,
        'userName': userName,
        'comment': comment,
        'timestamp': Timestamp.now(),
      });
    }
    return null;
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

  Future<void> deleteEmergencyContact(String docid) {
    return moduleContatcsEmergencyContact.doc(docid).delete();
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

  Future addVoting(String title, Map participants, DateTime dateAndTime) {
    return moduleVoting.add({
      'title': title,
      'participants': participants,
      'timer': dateAndTime,
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

  Future setAdmin(String docid, String userType) {
    return userType == 'admin'
        ? userProfile.doc(docid).update({
            'userType': 'admin',
          })
        : userProfile.doc(docid).update({
            'userType': 'user',
          });
  }

  Future disableAccount(String docid) {
    return userProfile.doc(docid).update({
      'userType': 'disabled',
    });
  }

  Future enableAccount(String docid) {
    return userProfile.doc(docid).update({
      'userType': 'user',
    });
  }

  Future getuserdata() async {
    String currentuserid = AuthService().userId();
    dynamic userdata = await userProfile.doc(currentuserid).get();
    return userdata;
  }

  Future uploadPhotodetails(String uid, Timestamp timestamp, String url,
      String caption, String username, String profilepicture) {
    return moduleSocialPhotos.add({
      'uid': uid,
      'username': username,
      'timestamp': timestamp,
      'url': url,
      'caption': caption,
      'likes': 0,
      'comments': 0,
      'profile_picture': profilepicture
    }).then((_) async {
      QuerySnapshot querySnapshot =
          await moduleSocialPhotos.where('uid', isEqualTo: uid).get();
      int noOfPhotos = querySnapshot.docs.length;
      moduleSocial.doc(uid).update({'posts': noOfPhotos});
    });
  }

  Future<String> getUserNameSocial() async {
    String currentuserid = AuthService().userId();
    dynamic socialUserName = await moduleSocial.doc(currentuserid).get();
    return socialUserName.data()['username'];
  }

  Future setUserNameSocial(String username, String uid) {
    moduleSocialUserNames.doc(username).set({
      'uid': uid,
    }).catchError((e) {
      print(e);
    });

    return moduleSocial.doc(uid).update({
      'username': username,
      'searchKey': username[0],
    });
  }

  void followUser(String loggedinUserUid, String toFollowUserUid) {
    moduleSocial
        .doc(loggedinUserUid)
        .collection('following')
        .doc(toFollowUserUid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        moduleSocial
            .doc(loggedinUserUid)
            .collection('following')
            .doc(toFollowUserUid)
            .delete();
        moduleSocial
            .doc(toFollowUserUid)
            .collection('followers')
            .doc(loggedinUserUid)
            .delete();
        moduleSocial
            .doc(loggedinUserUid)
            .collection('following')
            .get()
            .then((QuerySnapshot querySnapshot) {
          moduleSocial.doc(loggedinUserUid).update({
            'following': querySnapshot.docs.length,
          });
        });

        moduleSocial
            .doc(toFollowUserUid)
            .collection('followers')
            .get()
            .then((QuerySnapshot querySnapshot) {
          moduleSocial.doc(toFollowUserUid).update({
            'followers': querySnapshot.docs.length,
          });
        });
      } else {
        moduleSocial
            .doc(loggedinUserUid)
            .collection('following')
            .doc(toFollowUserUid)
            .set({
          'uid': toFollowUserUid,
          //  'followingphotos': moduleSocial.doc(toFollowUserUid).collection('photos'),
        });
        moduleSocial
            .doc(toFollowUserUid)
            .collection('followers')
            .doc(loggedinUserUid)
            .set({
          'uid': loggedinUserUid,
        });
        moduleSocial
            .doc(loggedinUserUid)
            .collection('following')
            .get()
            .then((QuerySnapshot querySnapshot) {
          moduleSocial.doc(loggedinUserUid).update({
            'following': querySnapshot.docs.length,
          });
        });

        moduleSocial
            .doc(toFollowUserUid)
            .collection('followers')
            .get()
            .then((QuerySnapshot querySnapshot) {
          moduleSocial.doc(toFollowUserUid).update({
            'followers': querySnapshot.docs.length,
          });
        });
      }
    });
  }
}
