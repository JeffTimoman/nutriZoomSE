import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gabunginfrontend/pages/kalkulasiNutrisi.dart';
import 'package:gabunginfrontend/pages/layout_textfield.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';

class nutritionPage extends StatefulWidget {
  const nutritionPage({Key? key}) : super(key: key);

  @override
  State<nutritionPage> createState() => _nutritionPageState();
}

class _nutritionPageState extends State<nutritionPage> {
  TextEditingController beratBadanController = TextEditingController();
  TextEditingController tinggiBadanController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  String intensitasOlahraga = '';
  String gender = '';
  int protein = 0, karbo = 0,lemak = 0;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Hitung Nutrisi Harian",
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
              MaterialPageRoute(builder: (context) => TapBar()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Mari kita mulai perhitungannya',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Perempuan',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text('Perempuan'),
                      Radio<String>(
                        value: 'Laki-laki',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text('Laki-laki'),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 0),
                  Text(
                    'Berat Badan',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: beratBadanController,
                    decoration: InputDecoration(
                      hintText: 'Masukan berat mu yaa.',
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan berat badan';
                      }
                      int? parsedValue = int.tryParse(value);
                      if (parsedValue == null) {
                        return 'Masukan angka yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Tinggi Badan',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: tinggiBadanController,
                    decoration: InputDecoration(
                      hintText: 'Masukan tinggi kamu sendiri yaa.',
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan berat badan';
                      }
                      int? parsedValue = int.tryParse(value);
                      if (parsedValue == null) {
                        return 'Masukan angka yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Usia',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: usiaController,
                    decoration: InputDecoration(
                      hintText: 'Usia kamu sekarang berapa?',
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan usia';
                      }
                      int? parsedValue = int.tryParse(value);
                      if (parsedValue == null) {
                        return 'Masukan angka yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Intensitas Berolahraga',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  DropdownButton<String>(
                    value: intensitasOlahraga.isNotEmpty ? intensitasOlahraga : null,
                    hint: Text('Pilih intensitas olahraga'),
                    items: <String>[
                      'Sangat Jarang berolahraga',
                      'Jarang olahraga',
                      'Cukup olahraga',
                      'Sering olahraga',
                      'Sangat sering olahraga',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        intensitasOlahraga = newValue ?? '';
                        print(intensitasOlahraga);
                        print(gender);
                      });
                    },
                  ),

                const SizedBox(height: 50),
                  Center(
                    child: Container(
                      width: 154,
                      height: 42,
                      decoration: BoxDecoration(color: Color(0xff3C6142), borderRadius: BorderRadius.circular(20)),
                      child: TextButton(

                        onPressed: () {
                          calculateNutrition();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WidgetNutrisi(proteinResult: protein, fatResult: lemak, carboResult: karbo),
                            ),
                          );
                        },
                        child: Text(
                          "Hitung",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),

                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void calculateNutrition() {
    double beratBadan = double.tryParse(beratBadanController.text) ?? 0.0;
    double tinggiBadan = double.tryParse(tinggiBadanController.text) ?? 0.0;
    int usia = int.tryParse(usiaController.text) ?? 0;
    double angkaOlahraga = 0.0;
    double kalori = 0;
    

    if (gender == 'Perempuan') {
      kalori = (655 + (9.6 * beratBadan) + (1.8 * tinggiBadan) - (4.7 * usia)) ;
      if (intensitasOlahraga == 'Sangat Jarang berolahraga') {
        angkaOlahraga = 1.2;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Jarang olahraga') {
        angkaOlahraga = 1.375;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Cukup olahraga') {
        angkaOlahraga = 1.5;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Sering olahraga') {
        angkaOlahraga = 1.7;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Sangat sering olahraga') {
        angkaOlahraga = 1.9;
        kalori = (kalori * angkaOlahraga);
      }
    } else if (gender == 'Laki-laki') {
      kalori = (66 + (13.7 * beratBadan) + (5 * tinggiBadan) - (6.8 * usia));
      
      if (intensitasOlahraga == 'Sangat Jarang berolahraga') {
        angkaOlahraga = 1.2;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Jarang olahraga') {
        angkaOlahraga = 1.375;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Cukup olahraga') {
        angkaOlahraga = 1.55;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Sering olahraga') {
        angkaOlahraga = 1.7;
        kalori = (kalori * angkaOlahraga);
      } else if (intensitasOlahraga == 'Sangat sering olahraga') {
        angkaOlahraga = 1.9;
        kalori = (kalori * angkaOlahraga);
      }
    }

    print(kalori);

    protein = (0.15 * kalori / 4).toInt();
    karbo = (0.6 * kalori / 4).toInt();
    lemak = (0.15 * kalori / 9 ).toInt();
    print(protein);
    print(karbo);
    print(lemak);

  

    // Perform calculations using the input values and angkaOlahraga
    // ...

    // Example usage of the calculated values
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WidgetNutrisi(
          proteinResult: protein,
          fatResult: karbo,
          carboResult: lemak,
        ),
      ),
    );
  }
}