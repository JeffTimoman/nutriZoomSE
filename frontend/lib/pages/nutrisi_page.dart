// import 'package:bagianjosh/pages/layout_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gabunginfrontend/pages/layout_textfield.dart';


class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        // theme: ThemeData(fontFamily: 'Montserrat'),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor:  Color(0xff3C6142) ,
              title: Text("Nutrisi Harian",
              style: TextStyle(
                color: Colors.white),
              ),
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
              leading: Container(
                margin: EdgeInsets.all(18),
                // alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/arrow-left.svg',
                  height: 3, width: 3,
                  color:Colors.white,
                ),
              ),
            ),
          
            body: Center(
              child: Container(          
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('Mari kita mulai perhitungannya'),
                      alignment: Alignment.topLeft,
                      height: 20,
                    ),
          
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 2,
                    ),
          
                    // Text Field
                    layoutTextField(context, "Berat Badan", "Masukkan berat badanmu"),
                    layoutTextField(context, "Tinggi Badan", "Masukkan tinggi badanmu"),
                    layoutTextField(context, "Usia", "Masukkan usiamu"),
                         
                    Container(
                      child: Text('Intensitas Berolahraga'),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom:10),
                      child: Text('*Pilih salah satu',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          color: Colors.red.withOpacity(0.5)
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    
                    // Dropdown  
                    Container(
                      // width: 400,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: dropdown_Intensitas()),
                    
                    Container(height: 200),  
                     
                    // Button
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Color(0xff3C6142),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      width: 150,
                      child: TextButton(
                        onPressed: () {}, 
                        child: Text("HITUNG",
                        style: TextStyle(
                          color: Colors.white
                        ),)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Dropdown List
class dropdown_Intensitas extends StatefulWidget {
  @override
  State<dropdown_Intensitas> createState() => _dropdown_IntensitasState();
}

class _dropdown_IntensitasState extends State<dropdown_Intensitas> {
  List<String> intensitasOptions = ['Sangat Jarang', 'Jarang', 'Cukup Sering', 'Sering', 'Sangat Sering'];
  String selectedValue = 'Sangat Jarang';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: SvgPicture.asset('assets/icons/line.svg'),
      value: selectedValue,
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
      items: intensitasOptions.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
  }
}