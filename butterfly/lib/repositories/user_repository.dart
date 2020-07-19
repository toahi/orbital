import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future<void>profileSetUp(
      File photo,
      String userId,
      String name,
      String gender,
      String interestedIn,
      DateTime age,
      GeoPoint location,
  )
    async{
      StorageUploadTask storageUploadTask;
      storageUploadTask = FirebaseStorage.instance
          .ref()
          .child('userPhotos')
          .child(userId)
          .putFile(photo);

      return await storageUploadTask.onComplete.then(
          (ref) async {
            await ref.ref.getDownloadURL().then((url) async {
              await _firestore.collection('users').document(userId).setData({
                'uid' : userId,
                'photourl' : url,
                'name'  : name,
                'location' : location,
                'gender' : gender,
                'interestedIn' : interestedIn,
                'age' : age

              });
            });
          }
      );

    }

  Future<void>profileUpdate(
      File photo,
      String userId,
      String name,
      String gender,
      String interestedIn,
      DateTime age,
      GeoPoint location,
      )
  async{
    StorageUploadTask storageUploadTask;

    FirebaseStorage.instance
        .ref()
        .child('userPhotos')
        .child(userId)
        .delete().then((_) => print('Successfully deleted photo' ));

    storageUploadTask = FirebaseStorage.instance
        .ref()
        .child('userPhotos')
        .child(userId)
        .putFile(photo);

    return await storageUploadTask.onComplete.then(
            (ref) async {
          await ref.ref.getDownloadURL().then((url) async {
            await _firestore.collection('users').document(userId).setData({
              'uid' : userId,
              'photourl' : url,
              'name'  : name,
              'location' : location,
              'gender' : gender,
              'interestedIn' : interestedIn,
              'age' : age

            });
          });
        }
    );

  }


}

