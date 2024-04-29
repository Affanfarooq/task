import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier{

  Color selectedColor=Colors.purple.shade700;
  bool light=false;

  void loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SAVE VALUE : ${prefs.getBool('isDarkMode')}");
    if(prefs.getBool('isDarkMode')==true){
      selectedColor = Colors.purple.shade700;
      light = true;
      notifyListeners();
    }else if(prefs.getBool('isDarkMode')==false){
      selectedColor = Colors.black87;
      light = false;
      notifyListeners();
    }
  }

  void setTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isDarkMode')==true){
      selectedColor = Colors.purple.shade700;
      prefs.setBool('isDarkMode', false);
      light = false;
      notifyListeners();
    }else if(prefs.getBool('isDarkMode')==false){
      selectedColor = Colors.black87;
      prefs.setBool('isDarkMode', true);
      light = true;
      notifyListeners();
    }
  }

}