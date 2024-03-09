import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/intro_screen_pages.dart/intro_1.dart';
import 'package:gabunginfrontend/pages/intro_screen_pages.dart/intro_2.dart';
import 'package:gabunginfrontend/pages/intro_screen_pages.dart/intro_3.dart';
import 'package:gabunginfrontend/pages/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  // const IntroScreen({Key key}) : super(key: key);
  const IntroScreen({super.key});


  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //controller
  PageController _controller = PageController();

  //cek di last page
  bool onLastPage = false;
  bool onFirstPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                onFirstPage = (index == 0);
              });
            },
            children: [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),

          // dot indicator
          Container(
            alignment: Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => loginpage()), // TOMBOL SEMENTARA
                        );
                      },
                  child: Text("Skip"),
                ),

                //dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                //next/done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => loginpage()),
                          );
                        },
                        child: Text("Done"),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Text("Next"),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/pages/intro_screen_pages.dart/intro_1.dart';
// import 'package:gabunginfrontend/pages/intro_screen_pages.dart/intro_2.dart';
// import 'package:gabunginfrontend/pages/intro_screen_pages.dart/intro_3.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});

//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   //controller
//   PageController _controller = PageController();

//   //cek di last page
//   bool onLastPage = false;
//   bool onFirstPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         PageView(
//           controller: _controller,
//           onPageChanged: (index) {
//             setState(() {
//               onLastPage = (index == 2);
//               onFirstPage = (index == 0);
//             });
//           },
//           children: [
//             IntroScreen1(),
//             IntroScreen2(),
//             IntroScreen3(),
//           ],
//         ),

//         // dot indicator
//         Container(
//             alignment: Alignment(0, 0.8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 //skip
//                 GestureDetector(
//                   onTap: () {
//                     _controller.jumpToPage(2);
//                   },
//                   child: Text("Skip"),
//                 ),

//                 //dot indicator
//                 SmoothPageIndicator(controller: _controller, count: 3),

//                 //next/done
//                 onLastPage
//                     ? GestureDetector(
//                         onTap: () {
//                           _controller.nextPage(
//                               duration: Duration(milliseconds: 300),
//                               curve: Curves.easeIn);
//                         },
//                         child: Text("Done"),
//                       )
//                     : GestureDetector(
//                         onTap: () {
//                           _controller.nextPage(
//                               duration: Duration(milliseconds: 300),
//                               curve: Curves.easeIn);
//                         },
//                         child: Text("Next"),

                        
//                       ),
//               ],
//             ))
//       ],
//     ));
//   }
// }
