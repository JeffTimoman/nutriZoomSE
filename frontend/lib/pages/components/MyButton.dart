import 'package:bagianjosh/pages/kalkulasiNutrisi.dart';
import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/pages/kalkulasiNutrisi.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> WidgetNutrisi()));
      },
      child: Container(
        width: 154,
        height: 42,
        // padding: const EdgeInsets.all(25),
        // margin: const EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(color: Color(0xff3C6142), borderRadius: BorderRadius.circular(20)),
        child: const Center(
          child: Text(
            "MASUK",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
        ),
      ),
    );
  }
}