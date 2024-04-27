import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/theme_changer_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Consumer<ThemeChanger>(builder: (context, val, child){
            return Checkbox(
                value: val.light,
                onChanged: (bool? value) {
                  val.setTheme();
                },
              );
          }),
        ],
      ),
    );
  }
}
