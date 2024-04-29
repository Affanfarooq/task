import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Providers/theme_changer_provider.dart';
import 'package:task/Widgets/text.dart';

class ThemeSwitchScreen extends StatefulWidget {
  @override
  _ThemeSwitchScreenState createState() => _ThemeSwitchScreenState();
}

class _ThemeSwitchScreenState extends State<ThemeSwitchScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    // _loadThemePreferences();
    _getAppVersion();
  }

  void _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ThemeChanger>(builder: (context, val, child) {
              return SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: val.selectedColor,
                title: Text('Dark Mode'),
                value: val.light,
                onChanged: (bool? value) {
                  val.setTheme();
                },
              );
            }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Version: $_appVersion',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.info,color: Colors.black54,),
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: FlutterLogo(),
                      applicationName: 'Task App',
                      applicationVersion: _appVersion,
                      children: [
                        Text('Developed by Affan Farooq'),
                        Text('maffanfarooq@gmail.com'),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            if (!bool.fromEnvironment('dart.vm.product'))
              Text(
                'Debug Mode',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
