import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {

  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepository({
    FirebaseAuth firebaseAuth,
    Firestore firestore
  })
      :_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  Future<void> signInWithEmail(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> isFirstTime (userID) async {
    bool exist;
    await Firestore.instance.collection('users').document(userID).get().then((user){
      exist = user.exists;
    });
    return exist;
  }

  Future<void> signUpWithEmail(String email, String password) async {
    print (_firebaseAuth);
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //profile setup


}

