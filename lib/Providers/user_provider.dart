import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/Models/user_model.dart';

class UserProfileProvider extends ChangeNotifier {
  late UserProfile _userProfile = UserProfile(name: '', email: '');

  UserProfile get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    _userProfile = UserProfile.fromMap(userData);
    notifyListeners();
  }


  bool isLoading = false;
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('Tasks');

  Future<void> addTask(TextEditingController title, TextEditingController description) async {
    try {
      isLoading = true;
      notifyListeners();
      DocumentReference docRef = tasksCollection.doc();
      await docRef.set({
        'id': docRef.id,
        'title': title.text,
        'description': description.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      title.clear();
      description.clear();
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Task added successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      isLoading = false;
      title.clear();
      description.clear();
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Can \'t upload task for some reason',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
      print('Error uploading task: $e');
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