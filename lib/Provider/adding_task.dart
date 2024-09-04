import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AddingTask extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? user = FirebaseAuth.instance.currentUser?.uid;

  Future<void> Adding(
      TextEditingController task, TextEditingController title) async {
    DocumentReference<Map<String, dynamic>> collectioninstance = _firestore
        .collection('users')
        .doc(user)
        .collection('Tasks')
        .doc(title.text);
    try {
      await collectioninstance.set({"Task": task.text});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> Deleteing(TextEditingController title) async {
    DocumentReference<Map<String, dynamic>> collectioninstance = _firestore
        .collection('users')
        .doc(user)
        .collection('Tasks')
        .doc(title.text);

    try {
      await collectioninstance.delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
