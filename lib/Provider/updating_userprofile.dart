import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUserProfile extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updatingprofile(String username) async {
    String currentuser = _auth.currentUser!.uid;
    print(currentuser);

    DocumentReference<Map<String, dynamic>> updateprofile =
        _firestore.collection('users').doc(currentuser);

    try {
       updateprofile.update({'username': username});
    } catch (e) {
      print(e.toString());
    }
  }
  


}
