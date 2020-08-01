import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    FirebaseUser _user;
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => _user = value.user,
          );
    } catch (err) {
      _user = null;
    }
    return _user.uid;
  }

  Future<String> createUser(String email, String password) async {
    String _userID;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => _userID = value.user.uid,
        );
    return _userID;
  }

  Future<bool> checkLogin() async {
    return null == _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> currentUser() async {
    return _firebaseAuth.currentUser();
  }

  Future<String> getUserName() async {
    var _firebaseUser = await FirebaseAuth.instance.currentUser();
    print(_firebaseUser.uid);
//    DocumentSnapshot _doc =
//        await _firestore.collection("user").document(_firebaseUser.uid).get();
    return "test";
  }

  Future<bool> changePassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

//  Future<bool> sendVerifyMail(String email) async {
//    await _firebaseAuth.se(email: email);
//    return true;
//  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    return;
  }
}
