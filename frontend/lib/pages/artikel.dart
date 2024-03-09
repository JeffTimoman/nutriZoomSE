import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/resep.dart';
// import 'package:gabunginfrontend/pages/resep.dart';

class artikelPage extends StatelessWidget {
  // const artikelPage({super.key});
  var judul = 'Kentang : Manfaat dan Kandungan Gizi untuk Kesehatan';
  var pengarang = 'Artika Sari ';
  var terbit = '6 Juni 2022';  
  var isiArtikel = 'Kentang (Solanum tuberosum L.) adalah salah satu jenis tumbuhan yang bagian akarnya biasanya dimakan sebagai sayuran. Selain itu, kentang juga memiliki manfaat pengobatan tertentu. Masyarakat telah menggunakan jus kentang mentah untuk mengatasi masalah kesehatan seperti sakit perut dan bengkak. Kandungan Gizi Kentang Kentang adalah sumber utama karbohidrat, sehingga sangat bermanfaat untuk meningkatkan energi di dalam tubuh seseorang, sehingga mereka dapat melakukan pekerjaan yang mereka lakukan. Selain itu, kentang memiliki banyak zat gizi, termasuk protein, karbohidrat, mineral (besi, fosfor, magnesium, natrium, kalsium, dan kalium), dan vitamin, terutama vitamin C dan B1.';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: null,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              // width: 430, 
              // height: 500,
              // height: double.infinity,
              child: Image(
                width: 100,
                height: 50,
                image: NetworkImage("https://learningherbs.com/wp-content/uploads/2010/07/Fotolia_56593441_S.jpg"),
                fit: BoxFit.fill,
              )
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> resepPage())
                  );
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                        ),
                    ),
                    ),
                ),
              ),
            ),

            //
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1.0,
              minChildSize: 0.6,
              builder: (context,ScrollController){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(33), topRight: Radius.circular(33))
                ),
                
                child: SingleChildScrollView(
                  controller: ScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Container(
                              height: 9, 
                              width: 81,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(33))
                              ),
                             )
                          ],
                        ),
                      ),
                  
                      
                      Text(
                        '$judul', 
                        // textAlign: TextAlign.left,                        
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,                        
                        ),
                      ),
                  
                      const SizedBox(height: 25),
                  
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(                              
                                borderRadius: BorderRadius.circular(33),
                                color: Color(0xffEAF7E9), // Ganti dengan warna hijau yang diinginkan
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xffEAF7E9),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xff4D5A4C),
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '$pengarang',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3C6142), // Ganti dengan warna teks yang diinginkan
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // Spacer(),
                          const SizedBox(width: 20),
                  
                  
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(                              
                                borderRadius: BorderRadius.circular(33),
                                color: Color(0xffEAF7E9), // Ganti dengan warna hijau yang diinginkan
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xffEAF7E9),
                                    child: Icon(
                                      Icons.edit_calendar,
                                      color: Color(0xff4D5A4C),
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '$terbit',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3C6142), // Ganti dengan warna teks yang diinginkan
                                    ),
                                  ),
                                ],
                              ),
                  
                              
                  
                  
                            ),
                          ),
                  
                        ],
                      ),
                      const SizedBox(height: 35),
                  
                  
                      Text(
                        '$isiArtikel',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 30),

                    ],
                  ),
                ),
              );
            }
            ),
            
          

          ],
        ),
      ),
    );
  }
}