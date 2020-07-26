import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<FirebaseUser> currentUser();

  Future<String> getUserName();

  Future<FirebaseUser> signIn(String email, String password);

  Future<String> createUser(String email, String password);

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user;
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => user = value.user,
        );
//        .catchError(() => user = null);
    return user;
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

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
