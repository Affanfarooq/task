import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/authentication_provider.dart';
import 'package:task/Screens/home_screen.dart';
import 'package:task/Screens/login_screen.dart';
import 'package:task/Widgets/profileImage.dart';
import 'package:task/Widgets/textField.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Icon(Icons.check_circle,size: 70,color: Colors.green,),
              content: Text('Your account has been create successfully'),
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'Images/B3.png'),
                fit: BoxFit.cover,opacity: 0.2
            )),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back_ios)),
                          Text(
                            "Create",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Account",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ProfielPicCard(),
                  SizedBox(
                    height: 15,
                  ),
                  textField(
                    controller: _nameController,
                    icon: Icon(CupertinoIcons.person, color: Colors.black45),
                    label: "Username",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  textField(
                    controller: _emailController,
                    icon: Icon(Icons.email_outlined, color: Colors.grey),
                    label: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  Consumer<AuthenticationProvider>(
                      builder: (context, val, child) {
                        return textField(
                          controller: _passwordController,
                          icon: Icon(Icons.password, color: Colors.grey),
                          label: "Password",
                          obscure: val.password,
                          suffixIcon: IconButton(
                              onPressed: () {
                                val.changePasswordValue();
                              },
                              icon: Icon(
                                Icons.remove_red_eye,
                                color:
                                val.password ? Colors.purple.shade300 : Colors.purple,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            // if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                            //     .hasMatch(value)) {
                            //   return 'Password must contain at least 8 characters, including one uppercase letter, one lowercase letter, one number, and one special character';
                            // }
                            return null;
                          },
                        );
                      }),
                  Consumer<AuthenticationProvider>(
                      builder: (context, val, child) {
                        return textField(
                          controller: _confirmPasswordController,
                          icon: Icon(Icons.password, color: Colors.grey),
                          label: "Confirm Password",
                          obscure: val.confirmPassword,
                          suffixIcon: IconButton(
                              onPressed: () {
                                val.changeConfirmPasswordValue();
                              },
                              icon: Icon(
                                Icons.remove_red_eye,
                                color:
                                val.confirmPassword ? Colors.purple.shade300 : Colors.purple,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            // if (!RegExp(
                            //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                            //     .hasMatch(value)) {
                            //   return 'Password must contain at least 8 characters, including one uppercase letter, one lowercase letter, one number, and one special character';
                            // }
                            return null;
                          },
                        );
                      }),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 54,
                              child: Consumer<AuthenticationProvider>(builder: (context, val ,child){
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: Colors.purple,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12))),
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()){
                                        if(val.profileImage!=''){
                                          _signUp();
                                          // val.registration(_nameController, _emailController, _passwordController, _confirmPasswordController,context);
                                        }else{
                                          showCupertinoDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: Icon(
                                                    Icons.warning,
                                                    color: Colors.orangeAccent,
                                                    size: 50,
                                                  ),
                                                  content: Text("Please select profile image"),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                        'Ok',
                                                        style: TextStyle(color: Colors.purple),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    },
                                    child: val.isLoading
                                        ? Center(child: CupertinoActivityIndicator(color: Colors.white70,))
                                        : Text(
                                      "SIGNUP",
                                      style: TextStyle(color: Colors.white),
                                    ));
                              })
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account ? ",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          " Login",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
