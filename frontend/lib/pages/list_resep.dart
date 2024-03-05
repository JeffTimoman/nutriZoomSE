import 'package:bagianjosh/constants/img_strings.dart';
import 'package:bagianjosh/pages/listResep_tile.dart';
import 'package:flutter/material.dart';

class ListResepPage extends StatelessWidget {
  final String judul_page;
  const ListResepPage({super.key, required this.judul_page});

  // Future getResep() async{
  //   var response = await http.get(Uri.http("http:/api/auth/recipes"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   items:[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),

      //   ]
      // ),
        // backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Color(0xff3C6142),
          title: Text(
            "Resep " + judul_page,
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          leading: IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
              weight: 10,
              )
          )
          
          // Container(
          //   margin: EdgeInsets.all(18),
          //   child: InkWell(
          //     child: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.white,
          //       size: 20,
          //       weight: 10,
          //     ),
          //   ),
          // ),
        ),

        // LIST VIEW DAFTAR HASIL RESEP
        body: Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 5),
            child: Expanded(
                child: ListView(
                  children: [
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 280,
                      cooking_time: "15:00",
                      portion: 4,
                      difficulty: "Easy",
                      cooking_step: 6,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 280,
                      cooking_time: "12:00",
                      portion: 4,
                      difficulty: "Easy",
                      cooking_step: 8,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 350,
                      cooking_time: "15:00",
                      portion: 8,
                      difficulty: "Easy",
                      cooking_step: 6,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Apa",
                      number_ofCal: 280,
                      cooking_time: "15:00",
                      portion: 4,
                      difficulty: "Hard",
                      cooking_step: 6,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 278,
                      cooking_time: "15:00",
                      portion: 10,
                      difficulty: "Easy",
                      cooking_step: 3,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 278,
                      cooking_time: "15:00",
                      portion: 10,
                      difficulty: "Easy",
                      cooking_step: 3,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 278,
                      cooking_time: "15:00",
                      portion: 10,
                      difficulty: "Easy",
                      cooking_step: 3,
                    ),
                    ListResep(
                      recipe_img: AssetImage(Tempe_Img),
                      recipe_name: "Tempe Orek",
                      number_ofCal: 278,
                      cooking_time: "15:00",
                      portion: 10,
                      difficulty: "Easy",
                      cooking_step: 3,
                    ),

                  ],
                )),
          ),
        ));
  }
}
