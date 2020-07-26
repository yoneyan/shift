import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shift/drawer.dart';

abstract class BaseAuth {
  Future<FirebaseUser> currentUser();

  Future<String> getUserName();

  Future<String> signIn(String email, String password);

  Future<String> createUser(String email, String password);

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

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

//        .catchError(() => );
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
    DocumentSnapshot _doc =
        await _firestore.collection("user").document(_firebaseUser.uid).get();
//    return _doc.data['name'];
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
