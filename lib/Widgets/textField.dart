
import 'package:flutter/material.dart';

Widget textField({
  String? label,
  Widget? icon,
  var controller,
  Widget? suffixIcon,
  bool? obscure = false,
  final String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
        validator: validator,
        obscureText: obscure!,
        controller: controller,
        decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 17),
        suffixIcon: suffixIcon,
        prefixIcon: icon,
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: label,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12)
        ),
        border: OutlineInputBorder(
          borderSide: validator != null ? BorderSide(color: Colors.orange) : BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
        ),
        hintStyle: TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.w500,
            fontSize: 15
        ),
      ),),
  );
}