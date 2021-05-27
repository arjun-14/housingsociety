import 'package:firebase_auth/firebase_auth.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseService db = DatabaseService();

  CurrentUser _userFromFireBase(User user) {
    return user != null
        ? CurrentUser(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
            profilePicture: user.photoURL)
        : null;
  }

  Stream<CurrentUser> get user {
    return _auth.userChanges().map(_userFromFireBase);
  }

  Future createUserWithEmailAndPassword(String email, String password,
      String name, String wing, String flatno) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      userCredential.user.updateProfile(displayName: name).then((_) {
        User user = _auth.currentUser;
        user.reload();
        User updateduser = _auth.currentUser;
        print(updateduser.displayName);
        db.setProfileonRegistration(user.uid, name, wing, flatno);
        return _userFromFireBase(updateduser);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user;
      return _userFromFireBase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  String userName() {
    final User user = _auth.currentUser;
    return user.displayName;
  }

  String userId() {
    final User user = _auth.currentUser;
    return user.uid;
  }

  Future signOut() async {
    await _auth.signOut();
    return null;
  }

  Future updateDisplayName(updatedName) async {
    _auth.currentUser
        .updateProfile(
      displayName: updatedName,
    )
        .then((_) {
      User user = _auth.currentUser;
      user.reload();
      User updateduser = _auth.currentUser;
      return _userFromFireBase(updateduser);
    });
    return userName();
  }

  Future updateProfilePicture(updatedProfilePicture) async {
    _auth.currentUser.updateProfile(
      photoURL: updatedProfilePicture,
    );
    return _userFromFireBase(_auth.currentUser);
  }

  Future updateEmail(email, password) async {
    try {
      EmailAuthCredential credential = EmailAuthProvider.credential(
          email: _auth.currentUser.email, password: password);
      await _auth.currentUser.reauthenticateWithCredential(credential);
      await _auth.currentUser.updateEmail(email);
      EmailAuthCredential newCredential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _auth.currentUser.reauthenticateWithCredential(newCredential);
      return 'Email updated successfully';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use')
        return 'The account already exists for that email.';
      if (e.code == 'wrong-password') return 'Wrong password provided.';
    } catch (e) {
      print(e);
      return 'An error occurred.Please try again.';
    }
  }

  Future updatePassword(oldPassword, newPassword) async {
    try {
      EmailAuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser.email,
        password: oldPassword,
      );
      await _auth.currentUser.reauthenticateWithCredential(credential);
      await _auth.currentUser.updatePassword(newPassword);
      EmailAuthCredential newCredential = EmailAuthProvider.credential(
        email: _auth.currentUser.email,
        password: newPassword,
      );
      await _auth.currentUser.reauthenticateWithCredential(newCredential);
      return 'Password updated successfully';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      }
    }
  }

  Future delteAccount() {
    _auth.signOut();
    return _auth.currentUser.delete();
  }
}
