import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/login.dart';
import 'package:gabunginfrontend/pages/resep.dart';
// import 'package:gabunginfrontend/pages/login.dart';
// import 'package:gabunginfrontend/pages/resep.dart';
import 'package:pie_chart/pie_chart.dart';


class WidgetNutrisi extends StatelessWidget {
  // const WidgetNutrisi({super.key});

  Map<String, double> dataMap = {
    "Protein": 98,
    "Karbohidrat": 394,
    "Lemak": 44,
  };

  //Untuk nanti dipake pas udah konek ke page sebelumnya
  var proteinResult = 98;
  var carboResult = 394;
  var fatResult = 44;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nutrisi Harian",
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
              MaterialPageRoute(builder: (context) => loginpage()),  // TOMBOL BACK SEMENTARA
            );
          },
        ),
      ),

      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hasil dari perhitungan Nutrisi Harianmu!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ) ,
                      ),                      
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),

                    const SizedBox(height: 40),

                    PieChart(dataMap: dataMap),

                    const SizedBox(height: 40),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rincian Nutrisi Harian',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ) ,
                      ),                      
                    ),

                    const SizedBox(height: 40),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Protein             : ${proteinResult.toString()} gram', 
                      ),
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Karbohidrat     : ${carboResult.toString()} gram', 
                      ),
                    ),
                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lemak              : ${fatResult.toString()} gram', 
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Text(
                    //   'Yuk cari resep untuk nutrisimu',
                    //   style: TextStyle(
                    //     color: Color(0xff3C6142)
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => resepPage()), // TOMBOL SEMENTARA
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Yuk cari ',
                          style: TextStyle(
                            color: Color(0xff3C6142),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Resep',
                              style: TextStyle(
                              decoration: TextDecoration.underline,
                              ),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => resepPage()),
                                );  
                            },
                            ),
                            TextSpan(
                              text: ' untuk nutrisimu',
                              style: TextStyle(
                              color: Color(0xff3C6142),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => resepPage()),
                        );
                      },
                      child: Container(
                        width: 100, // Atur lebar sesuai kebutuhan
                        height: 50, // Atur tinggi sesuai kebutuhan
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), // Atur border radius
                          // border: Border.all(color: Colors.black), // Atur border
                          color: Color(0xff1A5D1A),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.arrow_back), // Tambahkan ikon "KEMBALI"
                            Text(' KEMBALI',
                            style: TextStyle(
                              color: Colors.white
                            ),), // Tambahkan teks "KEMBALI"
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 50),

                  ],
                ),
              )
            ),
          )
        ),
    );
  }
}