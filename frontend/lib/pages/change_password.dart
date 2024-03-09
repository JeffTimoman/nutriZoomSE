import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/layout_textfield.dart';

class change_password extends StatefulWidget {
  const change_password({super.key});

  @override
  State<change_password> createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              // height: 350,
              decoration: BoxDecoration(
                color: Color(0xff3C6142)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white,),
                          ],
                        )
                      ),
                        
                      Expanded(
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
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Ubah Password",
                           style: TextStyle(
                           ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage("https://i.pinimg.com/564x/35/04/d5/3504d58d12e46855f9bc0ff191331f8c.jpg"),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Clarensia Novia",
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        "@bygum_masak",
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
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
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ListView(
                                children: [
                                  layoutTextField(context, "Password Lama", "Masukkan password lamamu di sini"),
                                  layoutTextField(context, "Password Baru", "Masukkan password barumu di sini"),                              ],
                              ),
                            )
                          ),

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
                              child: Text("SIMPAN",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              )
                            ),
                          ),
                          SizedBox(height: 30,)
                        ]
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}