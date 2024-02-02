import 'package:flutter/material.dart';
import 'package:frontend/constants/img_strings.dart';
import 'package:lottie/lottie.dart';

class IntroScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3C6142),
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
                  "Ingin tahu pangan bergizi dan cara mengolahnya?",
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Lottie.network(
                tIntro_1,
                height: 350,
                width: 350,
              ),
            ],
          )
        ],
      ),
    );
    // return Container(
    //   color: Color(0xff3C6142),
    //   child: Center(
    //     child: Text("Page 1"),
    //   ),
    // );
  }
}
