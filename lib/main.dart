import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Screens/home_screen.dart';
import 'package:task/Screens/login_screen.dart';
import 'package:task/firebase_options.dart';
import 'Providers/authentication_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking authentication status
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          // User is logged in, navigate to the home page
          return HomePage();
        } else {
          // User is not logged in, navigate to the login page
          return LoginPage();
        }
      },
    );
  }
}