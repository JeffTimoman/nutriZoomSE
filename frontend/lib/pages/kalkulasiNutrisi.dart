import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/bottom_nav.dart';
import 'package:gabunginfrontend/pages/dataKalkulasiNutrisi.dart';
import 'package:gabunginfrontend/pages/login.dart';
import 'package:gabunginfrontend/pages/profile_page.dart';
import 'package:gabunginfrontend/pages/resep.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';
import 'package:pie_chart/pie_chart.dart';

class WidgetNutrisi extends StatefulWidget {
  final int proteinResult;
  final int carboResult;
  final int fatResult;

  const WidgetNutrisi({
    Key? key,
    required this.proteinResult,
    required this.carboResult,
    required this.fatResult,
  }) : super(key: key);

  @override
  _WidgetNutrisiState createState() => _WidgetNutrisiState();
}

class _WidgetNutrisiState extends State<WidgetNutrisi> {
  late int proteinResult;
  late int carboResult;
  late int fatResult;

  @override
  void initState() {
    super.initState();
    proteinResult = widget.proteinResult;
    carboResult = widget.carboResult;
    fatResult = widget.fatResult;
  }

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
              MaterialPageRoute(builder: (context) => ProfilePage()), // TOMBOL BACK SEMENTARA
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hasil dari perhitungan Nutrisi Harianmu!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  SizedBox(height: 40),
                  PieChart(dataMap: {
                    "Protein": proteinResult.toDouble(),
                    "Karbohidrat": carboResult.toDouble(),
                    "Lemak": fatResult.toDouble(),
                  }),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rincian Nutrisi Harian',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Protein             : ${proteinResult.toString()} gram'),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Karbohidrat     : ${carboResult.toString()} gram'),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Lemak              : ${fatResult.toString()} gram'),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TapBar()),
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
                                  MaterialPageRoute(builder: (context) => TapBar()),
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
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar(currentIndex: 4,)),
                      );
                    },
                    child: Container(
                      width: 100, // Atur lebar sesuai kebutuhan
                      height: 50, // Atur tinggi sesuai kebutuhan
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100), // Atur border radius
                        color: Color(0xff1A5D1A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' KEMBALI',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}