// import 'package:bagianjosh/api_data/article/view.dart';
import 'package:bagianjosh/api_data/test_article/inibuatview.dart';
import 'package:bagianjosh/pages/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewViewVIew(),
    );
  }
}

class MMyApp extends StatelessWidget {
  const MMyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: const TextTheme(
          //judul page
          headline1: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 25,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),

          //judul content
          headline2: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600),

          //profile title
          headline3: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
              shadows: [
                Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0))
              ]),

          //profile sub title (email)
          subtitle1: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 2.0))
              ]),

          //body
          bodyText1: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500),

          //button
          button: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500),
        )),
        home: IntroScreen());
  }
}
