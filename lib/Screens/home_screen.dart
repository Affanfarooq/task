import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:task/Screens/Dashboard.dart';
import 'package:task/Screens/Profile.dart';
import 'package:task/Screens/Settings.dart';
import 'package:task/Screens/login_screen.dart';
import 'package:task/Widgets/text.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
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
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarHeight: 100,
            isTitleCenter: false,
            appBarPadding: EdgeInsets.only(top: 45),
            trailing: IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (route) => false);
            }, icon: Icon(Icons.logout)),
            title:
            Row(
              children: [
                text(" MY TASKS", 20, FontWeight.w800, Colors.black),
                SizedBox(width: 10,),
                Icon(Icons.access_alarms_sharp,color: Colors.black38,)
              ],
            ),
            appBarColor: Colors.white,),
        slider: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade100, Colors.deepPurpleAccent.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.only(top: 30),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white70,
                child: CircleAvatar(
                  radius: 57,
                  backgroundImage: Image.network(
                      'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
                      .image,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Nick',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ...[
                Menu(Icons.home, 'Home',(){}),
                Menu(Icons.add_comment, 'Add Task',(){}),
                Menu(Icons.check_circle, 'Completed Tasks',(){}),
                Menu(Icons.pending_actions_rounded, 'Pending Tasks',(){}),
                Menu(Icons.person, 'Profile',(){}),
                Menu(Icons.settings, 'Setting',(){}),
                Menu(Icons.logout, 'LogOut',(){
                })
              ].map((menu) => _SliderMenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  ontap: menu.onTap,
                  ))
                  .toList(),
            ],
          ),
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
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
class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function ontap;

  const _SliderMenuItem(
      {Key? key,
        required this.title,
        required this.iconData,
        required this.ontap,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Colors.black),
        onTap: ontap());
  }
}
class Menu {
  final IconData iconData;
  final String title;
  final Function onTap;

  Menu(this.iconData, this.title, this.onTap);
}