import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/Screens/Dashboard.dart';
import 'package:task/Screens/Profile.dart';
import 'package:task/Screens/Settings.dart';
import 'package:task/Screens/login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // After signing out, navigate back to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

User? user=FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Dashboard(),
    Profile(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 85, // Adjust the height as needed
        child: FloatingNavbar(
          backgroundColor: Colors.purple.shade700,
          borderRadius: 12,
          unselectedItemColor: Colors.white70,
          selectedBackgroundColor: Colors.purple.shade800,
          selectedItemColor: Colors.white,
          fontSize: 9,
          margin: EdgeInsets.zero,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            FloatingNavbarItem(icon: Icons.dashboard_outlined, title: 'Dashboard',),
            FloatingNavbarItem(icon: Icons.person_outline, title: 'Profile'),
            FloatingNavbarItem(icon: CupertinoIcons.settings, title: 'Settings'),
          ],
        ),
      ),
    );
  }
}
