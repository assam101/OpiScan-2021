import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';

class AuthService {
  final uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  AuthService({this.uid});

  // create user obj based on FirebaseUser
  UserM _userFromFirebaseUser(User user) {
    return user != null
        ? UserM(
            uid: user.uid, name: user.email.split('@')[0], email: user.email)
        : null;
  }

  // auth change user stream
  Stream<UserM> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String categorie) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      result.user.sendEmailVerification();

      await userCollection.doc(result.user.uid).set({
        'email': email,
        'password': password,
        'listfavoris': FieldValue.arrayUnion([]),
        'categorie': categorie
      });
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<UserM> getUser() {
    return userCollection.doc(this.uid).snapshots().map(_getUser);
  }

  UserM _getUser(DocumentSnapshot snapshot) {
    return UserM(
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot.id,
        categorie: snapshot['categorie']);
  }

  Future addList(String reference) async {
    try {
      await userCollection.doc(this.uid).update({
        'listFavoris': FieldValue.arrayUnion([reference])
      });
    } catch (e) {
      return null;
    }
  }

  Future removeList(String reference) async {
    try {
      await userCollection.doc(this.uid).update({
        'listFavoris': FieldValue.arrayRemove([reference])
      });
    } catch (e) {
      return null;
    }
  }

  Stream<List> getListFavoris() {
    return userCollection.doc(uid).snapshots().map(_getListFavoris);
  }

  List _getListFavoris(DocumentSnapshot snapshot) {
    try {
      return snapshot['listFavoris'];
    } catch (e) {
      return null;
    }
  }
}
