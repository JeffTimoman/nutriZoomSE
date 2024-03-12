
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/bmi/bmi_result.dart';
import 'package:gabunginfrontend/pages/bmi/height_widget.dart';

class BmiCalc extends StatefulWidget {
  const BmiCalc({super.key});

  @override
  State<BmiCalc> createState() => _BmiCalcState();
}

class _BmiCalcState extends State<BmiCalc> {
  int currentindex = 0;   //_gender
  int _height = 150;
  bool _isFinished = false;
  // double bmiScore = 0;
  double result = 0;
  int age = 0;
  double weight = 0;

  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3C6142),
          title: Text(
            "Kalkulator BMI",
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          leading: Container(
            margin: EdgeInsets.all(18),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
              weight: 10,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text("Jenis Kelamin: ", style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    radioButton("Pria", Colors.blueGrey, 0),
                    radioButton("Wanita", Colors.pink.shade200, 1),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),

                //input form
                //HEIGHT
                HeightWidget(onChange: (heightVal) {
                  _height = heightVal;
                }),

                SizedBox(
                  height: 30,
                ),

                //AGE & WEIGHT
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(3, 3),
                            blurRadius: 2,
                          )
                        ]),
                    child: Column(
                      children: [
                        Text(
                          "Umur",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Masukkan umurmu",
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Color(0xff3C6142), style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Berat Badan (kg)",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Masukkan berat badanmu",
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Color(0xff3C6142), style: BorderStyle.solid))),
                        ),
                      ],
                    )),

                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            _isFinished = false;
                            age = int.parse(ageController.value.text);
                            weight = double.parse(weightController.value.text);
                          });
                          calcBmi(age, weight);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BmiResult(bmiScore: result, age: age,)));
                        }, 
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3C6142)),
                        ),
                        child: Text("Hitung", style: Theme.of(context).textTheme.button,)),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calcBmi(int age, double weight){
    double bmi = weight/pow(_height/100, 2);
    // String bmi = finalresult.toStringAsFixed(2);
    setState(() {
      result = bmi;
    });
  }

  //calculate function
  void calucateBMI(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          offset: Offset(3, 3),
          blurRadius: 2,
        )
      ]),
      height: 80,
      child: TextButton(
        onPressed: () {
          calucateBMI(index);
        },
        child: Text(
          value,
          style: TextStyle(
            color: currentindex == index ? Colors.white : color,
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                currentindex == index ? color : Colors.grey.shade200),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
      ),
    ));
  }
}
