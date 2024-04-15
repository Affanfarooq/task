import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseServices{
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('Tasks');

  Future<void> addTask(TextEditingController title, TextEditingController description) async {
    try {
      DocumentReference docRef = tasksCollection.doc();
      await docRef.set({
        'id': docRef.id,
        'title': title.text,
        'description': description.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      title.clear();
      description.clear();
      Fluttertoast.showToast(
        msg: 'Task added successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Can \'t upload task for some reason',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      title.clear();
      description.clear();
    }
  }

  Future<void> updateTask(TextEditingController title, TextEditingController description, id) async {
    try {
      DocumentReference docRef = tasksCollection.doc(id);
      await docRef.update({
        'title': title.text,
        'description': description.text,
      });
      title.clear();
      description.clear();
      Fluttertoast.showToast(
        msg: 'Task updated successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Can \'t upload task for some reason',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      title.clear();
      description.clear();
    }
  }

}