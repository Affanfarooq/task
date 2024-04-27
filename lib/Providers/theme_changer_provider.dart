import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{

  bool light = true;
  Color selectedColor=Colors.purple.shade700;

  void setTheme(){
    if(light==true){
      selectedColor = Colors.purple.shade700;
      light = false;
      notifyListeners();
    }else if(light==false){
      selectedColor = Colors.black87;
      light = true;
      notifyListeners();
    }
  }

}