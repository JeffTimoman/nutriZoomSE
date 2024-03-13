import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/layout_textfield.dart';
import 'package:gabunginfrontend/pages/utility/sharedPreferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User{
  final String name, email, username, birth;

  User({required this.name, required this.email, required this.username, required this.birth});

}


class Controller{

  Future changeUserData(String name, String email, String username, String birth, String bearerToken) async{
    var url = Uri.parse('http://nutrizoom.site/api/auth/update_user_data');

    var response = await http.post(url,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization" : "Bearer $bearerToken"
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "username": username,
        "birth": birth
      })
    );

    return response.statusCode;
  }
 
  Future getUserData(String bearerToken) async{
    /*
      curl -X 'GET' \
  'http://nutrizoom.site/api/auth/get_user_data' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDA4MDA3NywianRpIjoiYWRiMmI2YzQtODk0Yy00MDBlLWEzMWQtNzZkYjIyZjE3OWU2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6OSwibmJmIjoxNzEwMDgwMDc3LCJjc3JmIjoiZmY3ZDI0ODctYTIxNS00OTRhLTliZTItNGJkMDgzMjZjN2IwIiwiZXhwIjoxNzEwMDgzNjc3fQ.qtWC65D6vrQVSmi1L5BpDuR52H5Fhkop370jWsSe8Js'
    */
    var url = Uri.parse('http://nutrizoom.site/api/auth/get_user_data');
    
    var response = await http.get(url,
      headers: {
        "accept": "application/json",
        "Authorization" : "Bearer $bearerToken",
        "Content-Type": "application/json",
      });

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      print(data);
      return User(
        name: data['name'],
        email: data['email'],
        username: data['username'],
        birth: data['birth']
      );
    } else {
      return null;
    }
  }
}

class change_profile extends StatefulWidget {
  const change_profile({super.key});

  @override
  State<change_profile> createState() => _change_profileState();
}

class _change_profileState extends State<change_profile> {
  var user = User(name: "", email: "", username: "", birth: "");
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var _token = "";
  // var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDI0MDAzNSwianRpIjoiZDBhNDM5MGItMWIwNS00ZGY4LWI0NGQtOGExNDFjMjEyYWFlIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MTYsIm5iZiI6MTcxMDI0MDAzNSwiY3NyZiI6IjY0NzQyZjgxLTM0YWQtNGI2MC1hYjRiLTAyNjQ3YWJiY2Y5OSIsImV4cCI6MTc0MTc3NjAzNX0.cL_oakN2EQTBgXVunq78YDgFvOACO9KsXTbZ7VGEMyQ";

  var controller = Controller();

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context).then((token) {
      print('Ini Token: $token');
      if (token != null) {
        setState(() {
          _token = token;
        });
        getUserData(_token!);
      }
    });
  }
  Future <void> getUserData(String s) async{
    var response = await controller.getUserData(_token);

    if (response != null){
      setState(() {
        user = response;
        fullNameController.text = user.name;
        usernameController.text = user.username;
        emailController.text = user.email;
      });
    }
    
  }
  
  Future <void> changeUserData() async{
    var name = fullNameController.text;
    var username = usernameController.text;
    var email = emailController.text;
    var birth = "";
    if (name == "" && username == "" && email == ""){
      print("Data tidak boleh kosong");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Gagal"),
            content: Text("Data tidak boleh kosong"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (name == user.name && username == user.username && email == user.email){
      print("Data tidak berubah");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Gagal"),
            content: Text("Data tidak berubah"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    var response = await controller.changeUserData(name, email, username, birth, _token);
    if (response == 200){
      print("Data berhasil diubah");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Berhasil"),
              content: Text("Data berhasil diubah"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        
        getUserData(_token);
    } else {
      print("Data gagal diubah");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Gagal"),
            content: Text("Data gagal diubah"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff3C6142),
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
                             InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white,)),
                            // Icon(
                            //   Icons.arrow_back_ios_new_sharp,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.help_outline_rounded,
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
                          "Ubah Profil",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/564x/35/04/d5/3504d58d12e46855f9bc0ff191331f8c.jpg"),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${user.name}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "@${user.username}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
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
                                spreadRadius: 1),
                          ]),
                      child: Column(
                          children: [
                            SizedBox(height: 40),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: ListView(
                                  children: [
                                    Text("Nama Lengkap"),
                                    TextFormField(
                                      controller: fullNameController,
                                    ), // Nama
                                    SizedBox(height: 20),
                                    Text("Username"),
                                    TextFormField(
                                      controller: usernameController,
                                    ), // Username
                                    //email
                                    SizedBox(height: 20),
                                    Text("Email"),
                                    TextFormField(
                                      controller: emailController,
                                    ), // Email
                                  ],
                                ),
                              ),
                            ),

                            // Button
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xff3C6142),
                                  borderRadius: BorderRadius.circular(100)),
                              width: 150,
                              child: TextButton(
                                  onPressed: () {
                                    changeUserData();
                                  },
                                  child: Text(
                                    "Simpan",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            SizedBox(height: 30),
                          ]),
                    ),
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

