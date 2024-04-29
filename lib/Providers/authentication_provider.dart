import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Screens/home_screen.dart';


class AuthenticationProvider extends ChangeNotifier{

  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => auth.authStateChanges();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool password = true;
  bool confirmPassword = true;
  String profileImage = '';
  bool isLoading = false;

  changePasswordValue(){
    password=!password;
    notifyListeners();
  }
  changeConfirmPasswordValue(){
    confirmPassword=!confirmPassword;
    notifyListeners();
  }

  Future getProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      profileImage = pickedFile.path.toString();
      notifyListeners();
    } else {
      print('No image selected');
    }
  }

  Future<String> uploadImageToFirebase(String imagePath,String name) async {
    // reference to the location in Firebase Storage
    final Reference ref = FirebaseStorage.instance.ref().child('Profile Images').child('${name}.jpg');

    // Upload the file to Firebase Storage
    final UploadTask uploadTask = ref.putFile(File(imagePath));

    // Get the download URL
    final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    final String url = await downloadUrl.ref.getDownloadURL();

    return url;
  }

  registration(TextEditingController name, TextEditingController email, TextEditingController password, TextEditingController confirmPassword, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading = true;
      notifyListeners();

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      if(userCredential.user!.uid!=''){
        await uploadImageToFirebase(profileImage, name.text).then((imageUrl){
          _firestore.collection('Users').doc(userCredential.user!.uid).set({
            'name': name.text.trim(),
            'email': email.text.trim(),
            'image': imageUrl,
            'uid': userCredential.user!.uid,
          });
        });
        isLoading = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomePage()), (route) => false);
        prefs.setBool('isDarkMode', false);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              content: Text("Signup Successful"),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }

      // Clear input fields
      name.clear();
      email.clear();
      password.clear();
      confirmPassword.clear();
      profileImage='';
    }on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      print('Firebase Auth Error: ${e.message}');

      // Show error dialog for specific authentication exceptions
      String errorMessage = 'An error occurred';
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email';
          break;
        case 'weak-password':
          errorMessage = 'The password provided is too weak';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
          break;
      }

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.purple),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
              )
            ],
          );
        },
      );
    }
  }

  Future<void> loginUser(TextEditingController email, TextEditingController password, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // Start loading state
      isLoading = true;
      notifyListeners();

      // Sign in the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if(userCredential.user!.uid!=''){
        // Stop loading state
        isLoading = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomePage()), (route) => false);
        prefs.setBool('isDarkMode', false);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              content: Text("Login Successful"),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
        email.clear();
        password.clear();
      }
    } on FirebaseAuthException catch (e) {
      isLoading=false;
      notifyListeners();
      String errorMessage = "An error occurred";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email";
      } else if (e.code == 'wrong-password') {
        errorMessage = "The provided password is invalid";
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

  }

  Future<void> updateProfileImage(String imagePath, String name) async {
    // Reference to the location of the existing profile image in Firebase Storage
    final Reference ref = FirebaseStorage.instance.ref().child('Profile Images').child('${name}.jpg');

    // Delete the existing profile image
    await ref.delete();

    // Upload the new profile image
    final String imageUrl = await uploadImageToFirebase(imagePath, name);

    // Update the profile image URL in Firestore
    await _firestore.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'image': imageUrl,
    });
  }
}
