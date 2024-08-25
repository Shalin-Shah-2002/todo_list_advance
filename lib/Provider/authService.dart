import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isSignedIn = true;

  bool get isSignedIn => _isSignedIn;

  late String _userid;
  String get userid => _userid;

  Future<String?> registerWithEmailPassword(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      _userid = user!.uid; //this variable is for userid 
      await _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> loginWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _isSignedIn = false;
    notifyListeners();
  }

  User? get currentUser {
    return _auth.currentUser;
  }
}
