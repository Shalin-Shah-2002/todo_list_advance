import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth reglogin_authenticaton = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userdata;

  Map<String, dynamic>? get userdata => _userdata;
  User? get user => _user;

  AuthService() {
    reglogin_authenticaton.authStateChanges().listen(_onstatechange);
  }

  Future<void> _fetchuserdata() async {
    if (_user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(_user!.uid).get();
      _userdata = userDoc.data() as Map<String, dynamic>?;
    }
  }

  Future<void> _onstatechange(User? user) async {
    _user = user;
    if (_user != null) {
      _fetchuserdata();
    }
    notifyListeners();
  }

  Future<void> _registerwithemailandpassword(
      String username, String email, String password) async {
    try {
      UserCredential result = await reglogin_authenticaton
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await _firestore.collection('user').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': username,
        });
        await _fetchuserdata();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> _signinwithemailandpassword(
      String email, String password) async {
    try {
      await reglogin_authenticaton.signInWithEmailAndPassword(
          email: email, password: password);
      await _fetchuserdata();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> _Signout() async {
    await reglogin_authenticaton.signOut();
    _userdata = null;
    notifyListeners();
  }
}
