import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pusatBantuan extends StatelessWidget {
  const pusatBantuan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff3C6142)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white,))
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.help_outline_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                            Container(
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 27,
                              ),
                              margin: EdgeInsets.all(7),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(top:10, bottom:15, left: 20, right: 20),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Halo Clarensia,",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white
                            )
                          )
                        ),
                        Container(
                          child: Text(
                            "ada yang bisa dibantu?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ),
                        SizedBox(height: 15,),
                        searchTextField()
                      ],
                    ),
                  ),

                  // Space
                  SizedBox(height: 25,),

                  // Kotak Putih bawah
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(5, 5),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            spreadRadius: 1
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Topic paling dicari"
                                ),
                                Divider(color: Colors.grey.shade500,
                                    thickness: 2,
                                ),
                                layoutTopikBantuan(context, "Bagaimana cara ubah password?"),
                                layoutTopikBantuan(context, "Bagaimana cara ubah password?"),
                                layoutTopikBantuan(context, "Bagaimana cara ubah password?"),
                                layoutTopikBantuan(context, "Bagaimana cara ubah password?"),
                                layoutTopikBantuan(context, "Bagaimana cara ubah password?"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
  
  layoutTopikBantuan(BuildContext context, String bantuan) {
    return Column(
      children: [
        Row(
          children: [
            Text("Bagaimana cara ubah password?"),
            Spacer(),
            Icon(Icons.arrow_forward_ios_sharp,
              color: Colors.black38,)
          ]
        ),
        Divider(
          color: Colors.grey.shade500,
          thickness: 2,
        )
      ],
    );
  }
  
  searchTextField(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: CupertinoSearchTextField(
          placeholder: "Cari bantuan lebih cepat di sini.",
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}