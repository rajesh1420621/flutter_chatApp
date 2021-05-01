import 'package:flutter/material.dart';

Widget appBarName(BuildContext context) {
  return AppBar(
    title: Text(
      'Sandesh',
    ),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      labelText:hintText,
      hintText:hintText,
      hintStyle: TextStyle(color: Colors.blue),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}


TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.blue,
        fontSize: 16
  );
}
TextStyle mediumTextStyle(){
  return TextStyle(
      color: Colors.black ,
      fontSize: 17
  );
}