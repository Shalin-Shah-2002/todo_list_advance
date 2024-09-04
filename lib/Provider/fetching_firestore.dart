import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FetchingFirestore with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _username;
  String? get username => _username;

  String? _email;
  String? get email => _email;

  Future<void> usernamedata() async {
    String? userid = FirebaseAuth.instance.currentUser?.uid;
    DocumentReference<Map<String, dynamic>> data =
        _firestore.collection('users').doc(userid);

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await data.get();

      _username = snapshot['username'];

      // print('Username: $_username');
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> userdata() async {
    String? userid = FirebaseAuth.instance.currentUser?.uid;
    DocumentReference<Map<String, dynamic>> userregisterdata =
        _firestore.collection('users').doc(userid);

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await userregisterdata.get();
      if (snapshot != null) {
        _email = snapshot['email'];
        // print('$_email');
        notifyListeners();
      } else {
        print("not found");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
