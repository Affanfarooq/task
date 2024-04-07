import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/Screens/home_screen.dart';
import 'package:task/Screens/login_screen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomePage()), (route) => false);
        // User signed up successfully
        print('User signed up: ${userCredential.user!.uid}');
        // Navigate to next screen or perform desired action
      } catch (e) {
        // Error occurred during sign up
        print('Error signing up: $e');
        // Show error message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign Up Error'),
              content: Text('$e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
               SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
