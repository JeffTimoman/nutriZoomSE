import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<String?> checkLoginStatus(BuildContext context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token != null) {
    return token;
  } else {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage()));
    return null;
    
  }


}