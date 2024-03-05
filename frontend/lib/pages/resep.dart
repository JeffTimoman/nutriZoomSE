import 'package:bagianjosh/pages/artikel.dart';
import 'package:bagianjosh/pages/login.dart';
import 'package:bagianjosh/pages/resepCard.dart';
import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/pages/artikel.dart';
// import 'package:gabunginfrontend/pages/login.dart';
// import 'package:gabunginfrontend/pages/resepCard.dart';

class resepPage extends StatelessWidget {
  const resepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Nutrisi",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff3C6142),
        toolbarHeight: 90,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => loginpage()),
            );
          },
        ),
      ),

      body: SafeArea(
        child: Container(
          color: Color(0xffF4FBF3),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:20),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bahan Pangan yang kamu cari ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: '(per 100 g)',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Garis
                Container(
                      height: 2,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),

                // SizedBox(height: 2), // Jarak antara teks dan RecipeCard
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> artikelPage()));
                  },
                  child: RecipeCard(
                    judul: "Dada Ayam", // Diubah ke api disini semua
                    gramnasi: "31 Gram",
                    gambarResep: "https://static.republika.co.id/uploads/images/inpicture_slide/potongan-dada-ayam-_180730212127-388.jpg",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}