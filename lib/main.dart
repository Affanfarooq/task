import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/theme_changer_provider.dart';
import 'package:task/Providers/user_provider.dart';
import 'package:task/Screens/home_screen.dart';
import 'package:task/Screens/login_screen.dart';
import 'package:task/firebase_options.dart';
import 'Providers/authentication_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider<UserProfileProvider>(
            create: (_) => UserProfileProvider()),
        ChangeNotifierProvider<ThemeChanger>(
            create: (_) => ThemeChanger()),
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

class AuthCheck extends StatefulWidget {
  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
