import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class BmiResult extends StatelessWidget {
  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? bmiIntrepretation;

  Color? bmiStatusColor;

  BmiResult({super.key, required this.bmiScore, required this.age});

  @override
  Widget build(BuildContext context) {
    setBmiIntepretation();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3C6142),
        title: Text(
          "Hasil BMI",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        leading: Container(
          margin: EdgeInsets.all(18),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
              weight: 10,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Card(
          color: Colors.white,
          elevation: 12,
          shape: const RoundedRectangleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hasil BMI Anda",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 10,
              ),
              PrettyGauge(
                gaugeSize: 300,
                minValue: 0,
                maxValue: 40,
                segments: [
                  GaugeSegment("UnderWeight", 18.5, Colors.blue),
                  GaugeSegment("Normal", 6.4, Colors.green),
                  GaugeSegment(
                    "OverWeight",
                    5,
                    Colors.orange,
                  ),
                  GaugeSegment("Obese", 10.1, Colors.red),
                ],
                valueWidget: Text(
                  bmiScore.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headline2,
                ),
                currentValue: bmiScore.toDouble(),
                needleColor: Color(0xff3C6142),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                bmiStatus!,
                style: Theme.of(context).textTheme.headline2,
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                bmiIntrepretation!,
                style: Theme.of(context).textTheme.bodyText1,
              ),

              // axes: <RadialAxis>[
              //   RadialAxis(
              //     minimum: 0,
              //     maximum: 40,
              //     ranges: <GaugeRange>[
              //       GaugeRange(startValue: 10, endValue: 18.5, color: Colors.blue, label: "Underweight",),
              //       GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green, label: "Normal weight",),
              //       GaugeRange(startValue: 24.9, endValue: 29.9, color: Colors.orange, label: "Overweight",),
              //       GaugeRange(startValue: 29.9, endValue: 40, color: Colors.red, label: "Obese",),
              //     ],
              //     pointers: <GaugePointer>[
              //       NeedlePointer(value:bmiScore,enableAnimation: true,),
              //     ],
              //     annotations: <GaugeAnnotation>[
              //       GaugeAnnotation(
              //         widget: Text(bmiScore.toStringAsFixed(2))
              //       ),
              //     ],
              //   )
              // ],
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Hitung Ulang",
                      style: Theme.of(context).textTheme.button,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3C6142),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void setBmiIntepretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obesitas";
      bmiIntrepretation =
          "Ayo jaga makan dan gaya hidup untuk kurangi obesitasmu!";
      bmiStatusColor = Colors.red;
    } else if (bmiScore >= 25) {
      bmiStatus = "Kelebihan Berat Badan";
      bmiIntrepretation = "pokonya ini overweight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiIntrepretation = "Kerja Bagus, pertahankan terus ya!";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Kekurangan Berat Badan";
      bmiIntrepretation = "pokonya ini underweight";
      bmiStatusColor = Colors.blue;
    }
  }
}
