import 'package:flutter/material.dart';
Widget text(String text,double fontSize, FontWeight fontWeight, Color color){
  return Text("$text",style: TextStyle(color: color,fontSize: fontSize,fontWeight: fontWeight),);
}