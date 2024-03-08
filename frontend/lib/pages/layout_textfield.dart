import 'package:flutter/material.dart';

Column layoutTextField(BuildContext context, String judul, String hint){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul, 
          style: TextStyle(
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff3C6142).withOpacity(0.15),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.normal
            ),    
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              )
            )
          ),  
        ),
        SizedBox(height: 12,)
      ],
    );
}