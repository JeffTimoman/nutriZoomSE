import 'package:flutter/material.dart';
import 'package:gabunginfrontend/constants/img_strings.dart';
// import 'package:gabunginfrontend/constant/img_string.dart';

class IntroScreen3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 100,
                child: Text(
                  "Kami solusinya!",
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Image(
                image: AssetImage(tLogo),
                width: 200,
                height: 150,
                fit: BoxFit.contain,),
              // Shimmer.fromColors( 
              //   highlightColor: Colors.transparent,
              //   baseColor: Colors.black,
              //   child: Image.asset(
              //     "assets/Nutri (4) 1.png",
              //     height: 350,
              //     width: 350,
              //     fit: BoxFit.contain,
              //   ), )
              
            ],
          )
        ],
      ),
    );
  }
}