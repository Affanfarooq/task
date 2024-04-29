import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Providers/theme_changer_provider.dart';
import 'package:task/Providers/user_provider.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Dashboard(),
    ProfileScreen(),
    ThemeSwitchScreen(),
  ];

  @override
  void initState() {
    final provider = Provider.of<UserProfileProvider>(context, listen: false);
    final theme = Provider.of<ThemeChanger>(context, listen: false);
    provider.fetchUserProfile();
    theme.loadSavedValue();
    // TODO: implement initState
    super.initState();
  }

  String _appBarTitle = 'MY TASKS';
  Icon icon = Icon(Icons.access_alarms_sharp, color: Colors.black38);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SliderDrawer(
            appBar: SliderAppBar(
              title: Row(
                children: [
                  text(_appBarTitle, 20, FontWeight.w800, Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                  icon
                ],
              ),
              appBarColor: Colors.white,
            ),
            slider: Consumer<ThemeChanger>(builder: (context, val, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      val.selectedColor.withOpacity(0.6),
                      val.selectedColor.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.only(top: 30),
                child: Consumer<UserProfileProvider>(builder: (context, val, child){
                  return ListView(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white70,
                        child: CircleAvatar(
                          radius: 57,
                          backgroundImage: Image.network(
                              val.userProfile.image)
                              .image,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        val.userProfile.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      ...[
                        Menu(Icons.home, 'Home', () {}),
                        Menu(Icons.add_comment, 'Add Task', () {}),
                        Menu(Icons.check_circle, 'Completed Tasks', () {}),
                        Menu(Icons.pending_actions_rounded, 'Pending Tasks', () {}),
                        Menu(Icons.person, 'Profile', () {}),
                        Menu(Icons.settings, 'Setting', () {}),
                        Menu(Icons.logout, 'LogOut', () {})
                      ].map((menu) => _SliderMenuItem(
                        title: menu.title,
                        iconData: menu.iconData,
                        ontap: menu.onTap,
                      ))
                          .toList(),
                    ],
                  );
                })
              );
            }),
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
          bottomNavigationBar: Consumer<ThemeChanger>(builder: (context, val, child) {
            return Container(
              height: 87,
              child: FloatingNavbar(
                backgroundColor: val.selectedColor,
                borderRadius: 12,
                unselectedItemColor: Colors.white70,
                selectedBackgroundColor: Colors.transparent.withOpacity(0.2),
                selectedItemColor: Colors.white,
                fontSize: 9,
                margin: EdgeInsets.zero,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    if (index == 0) {
                      _appBarTitle = "MY TASKS";
                      icon = Icon(Icons.access_alarms_sharp, color: Colors.black38);
                    }
                    if (index == 1) {
                      _appBarTitle = "PROFILE";
                      icon = Icon(CupertinoIcons.person, color: Colors.black38);
                    }
                    if (index == 2) {
                      _appBarTitle = "SETTINGS";
                      icon = Icon(CupertinoIcons.settings, color: Colors.black38);
                    }
                  });
                },
                currentIndex: _selectedIndex,
                items: [
                  FloatingNavbarItem(
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                  ),
                  FloatingNavbarItem(
                      icon: Icons.person_outline, title: 'Profile'),
                  FloatingNavbarItem(
                      icon: CupertinoIcons.settings, title: 'Settings'),
                ],
              ),
            );
          })),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function ontap;

  const _SliderMenuItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black87, fontFamily: 'BalsamiqSans_Regular',fontSize: 14.5)),
        leading: Icon(iconData, color: Colors.black54,),
        onTap: ontap());
  }
}

class Menu {
  final IconData iconData;
  final String title;
  final Function onTap;

  Menu(this.iconData, this.title, this.onTap);
}
