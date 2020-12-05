import 'package:firebase_auth/firebase_auth.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseService db = DatabaseService();

  CurrentUser _userFromFireBase(User user) {
    return user != null
        ? CurrentUser(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  Stream<CurrentUser> get user {
    return _auth.authStateChanges().map(_userFromFireBase);
  }

  Future createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user.updateProfile(displayName: name);
      print(userCredential.user.displayName);
      User user = userCredential.user;
      db.setProfileonRegistration(user.uid, name);
      return _userFromFireBase(userCredential.user);
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

  Future signOut() async {
    await _auth.signOut();
    return null;
  }
}
