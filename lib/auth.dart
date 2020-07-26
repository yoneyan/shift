import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> currentUser();

  Future<FirebaseUser> signIn(String email, String password);

  Future<String> createUser(String email, String password);

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
    String userID;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => userID = value.user.uid,
        );
    return userID;
  }

  Future<bool> checkLogin() async {
    return null == _firebaseAuth.currentUser();
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
