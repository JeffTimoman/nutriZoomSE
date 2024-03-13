import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/artikel_page.dart';
import 'package:gabunginfrontend/pages/bottom_nav.dart';
import 'package:gabunginfrontend/pages/change_password.dart';
import 'package:gabunginfrontend/pages/hasil_bahan.dart';
import 'package:gabunginfrontend/pages/home.dart';
import 'package:gabunginfrontend/pages/intro_screen.dart';
import 'package:gabunginfrontend/pages/list_resep.dart';
import 'package:gabunginfrontend/pages/profile_page.dart';
import 'package:gabunginfrontend/pages/recipe_details.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';
import 'package:gabunginfrontend/pages/test.dart';

// import 'package:gabunginfrontend/pages/hasil_bahan.dart';
// import 'package:gabunginfrontend/pages/intro_screen.dart';
// import 'package:gabunginfrontend/pages/tapBar_search.dart';
// import 'package:nutrizoom_apps/pages/tapBar_search.dart';

void main() {
  runApp( MMyApp());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProfilePage(),
//     );
//   }
// }

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
            fontSize: 23,
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),

        //judul content
        headline2: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
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

        //judul resep slider
        headline4: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Color(0xff3C6142),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Colors.grey,
            ),
          ],
        ),

        //headline judul content biar beda
        headline5: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600),

        //Khusus informasi gizi
        headline6: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Colors.black,
            letterSpacing: 2.5,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700),

        headlineLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 23,
          color: Color(0xff3C6142),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          // shadows: <Shadow>[
          //   Shadow(
          //     offset: Offset(2.0, 2.0),
          //     blurRadius: 3.0,
          //     color: Colors.grey,
          //   ),
          // ],
        ),

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
            fontSize: 15,
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),

        //button
        button: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500),

        //info resep
        bodyText2: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12,
            color: Colors.black54,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500),

        // versi bold bodytext1
        subtitle2: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      )),
      // home: HasilBahan(judul_bahan: "Bawang",)
      home: NavBar(),
      // home: IntroScreen(),
    );
  }
}
