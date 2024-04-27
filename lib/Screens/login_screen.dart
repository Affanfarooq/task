import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/authentication_provider.dart';
import '../Widgets/textField.dart';
import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'Images/B1.jpg'),
                fit: BoxFit.cover,opacity: 0.05
            )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6,top: 150),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          " Please sign in to continue.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  textField(
                    controller: _emailController,
                    icon: Icon(Icons.email_outlined, color: Colors.grey),
                    label: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // final emailRegex =
                      // RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      // if (!emailRegex.hasMatch(value)) {
                      //   return 'Please enter a valid email';
                      // }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forget Password ?  ",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 54,
                              child: Consumer<AuthenticationProvider>(builder: (context, val, child){
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: Colors.purple,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12))),
                                    onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        val.loginUser(_emailController, _passwordController,context);
                                      }
                                    },
                                    child: val.isLoading
                                        ? Center(child: CupertinoActivityIndicator(color: Colors.white70,))
                                        : Text(
                                      "LOGIN",
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
                        "Don't have an account ? ",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
                        },
                        child: Text(
                          " Register",
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
