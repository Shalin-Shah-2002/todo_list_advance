import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AddingTask extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? user = FirebaseAuth.instance.currentUser?.uid;
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  Future<void> Adding(
      {required TextEditingController task,
      required TextEditingController title}) async {
    DocumentReference<Map<String, dynamic>> collectioninstance = _firestore
        .collection('users')
        .doc(user)
        .collection('Tasks')
        .doc(title.text);
    try {
      await collectioninstance.set({"Task": task.text, "Check": _isChecked});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> Deleteing(String docId) async {
    DocumentReference<Map<String, dynamic>> collectioninstance =
        _firestore.collection('users').doc(user).collection('Tasks').doc(docId);

    try {
      await collectioninstance.delete();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> toggleCheckbox(bool? value, String docid) async {
    _isChecked = !_isChecked;
    DocumentReference<Map<String, dynamic>> collectioninstance =
        _firestore.collection('users').doc(user).collection("Tasks").doc(docid);

    try {
      await collectioninstance.update({"Check": _isChecked});
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
