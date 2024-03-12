import 'package:flutter/material.dart';

class HeightWidget extends StatefulWidget {
  
  final Function(int) onChange;

  const HeightWidget({super.key, required this.onChange});

  @override
  State<HeightWidget> createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget> {
  int _height = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Tinggi Badan (cm) ",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _height.toString(),
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                Text(
                  " cm",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )
              ],
            ),
            Slider(
              min: 0,
              max: 240,
              value: _height.toDouble(),
              activeColor: Color(0xff3C6142),
              thumbColor: Color(0xffEEE966),
              onChanged: (value) {
                setState(() {
                  _height = value.toInt();
                });
                widget.onChange(_height);
              },
            )
          ],
        ));
  }
}
