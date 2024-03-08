import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String judul;
  final String gramnasi;
  final String gambarResep;
  RecipeCard({
    required this.judul,
    required this.gramnasi,
    required this.gambarResep,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            bottom: 10,
            right: 310,
            child: Container(
              width: 210, // Atur lebar gambar sesuai kebutuhan
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: NetworkImage(gambarResep),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 80, // Atur jarak antara gambar dan teks
            top: 0,
            bottom: 0,
            right: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  judul,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // padding: EdgeInsets.all(5),
                  // margin: EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //   color: Colors.black.withOpacity(0.4),
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  // child: Row(
                  //   children: [
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.yellow,
                  //       size: 18,
                  //     ),
                  //     SizedBox(width: 7),
                  //     Text(rating),
                  //   ],
                  // ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      // Icon(
                      //   // Icons.schedule,
                      //   color: Colors.yellow,
                      //   size: 18,
                      // ),
                      SizedBox(width: 7),
                      Text(gramnasi,
                      style: TextStyle(
                        color: Colors.white
                      ),),
                    ],
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );

  }
}





// Container(
//       margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
//       width: MediaQuery.of(context).size.width,
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.6),
//             offset: Offset(
//               0.0,
//               10.0,
//             ),
//             blurRadius: 10.0,
//             spreadRadius: -6.0,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 20,
//             top: 10,
//             bottom: 10,
//             right: 310,
//             child: Container(
//               width: 200, // Atur lebar gambar sesuai kebutuhan
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 image: DecorationImage(
//                   image: NetworkImage(gambarResep),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 1),
//               child: Text(
//                 judul,
//                 style: TextStyle(
//                   fontSize: 19,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             alignment: Alignment.center,
//           ),
//           Align(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // padding: EdgeInsets.all(5),
//                   // margin: EdgeInsets.all(10),
//                   // decoration: BoxDecoration(
//                   //   color: Colors.black.withOpacity(0.4),
//                   //   borderRadius: BorderRadius.circular(15),
//                   // ),
//                   // child: Row(
//                   //   children: [
//                   //     Icon(
//                   //       Icons.star,
//                   //       color: Colors.yellow,
//                   //       size: 18,
//                   //     ),
//                   //     SizedBox(width: 7),
//                   //     Text(rating),
//                   //   ],
//                   // ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   margin: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.schedule,
//                         color: Colors.yellow,
//                         size: 18,
//                       ),
//                       SizedBox(width: 7),
//                       Text(gramnasi),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             alignment: Alignment.bottomLeft,
//           ),
//         ],
//       ),
//     );