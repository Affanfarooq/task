
import 'package:flutter/material.dart';

Widget textField({
  String? label,
  Widget? icon,
  var controller,
  Widget? suffixIcon,
  bool? obscure = false,
  final String? Function(String?)? validator,
  int? lines=1,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
        maxLines: lines,
        validator: validator,
        obscureText: obscure!,
        controller: controller,
        decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 17,horizontal: 20),
        suffixIcon: suffixIcon,
        prefixIcon: icon,
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: label,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)
        ),
        border: OutlineInputBorder(
          borderSide: validator != null ? BorderSide(color: Colors.orange) : BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.normal,
            fontSize: 15
        ),
      ),),
  );
}