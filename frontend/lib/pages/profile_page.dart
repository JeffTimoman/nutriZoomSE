// import 'package:bagianjosh/constants/img_strings.dart';
import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/Alen/profile_page/controller.dart';
// import 'package:gabunginfrontend/constant/img_string.dart';
import 'package:gabunginfrontend/constants/img_strings.dart';
import 'package:gabunginfrontend/pages/change_password.dart';
import 'package:gabunginfrontend/pages/change_profile.dart';
import 'package:gabunginfrontend/pages/login.dart';
// import 'package:gabunginfrontend/pages/profile_page/controller.dart';
import 'package:gabunginfrontend/pages/pusat_bantuan.dart';
import 'package:gabunginfrontend/pages/utility/sharedPreferences.dart';
// import 'package:gabunginfrontend/constant/img_string.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User{
  final String name, email, username, birth;

  User({required this.name, required this.email, required this.username, required this.birth});

}

class Controller{
  Future changePassword(String oldPassword, String newPassword, String bearerToken) async {
    /*
    curl -X 'POST' \
  'http://nutrizoom.site/api/auth/change_password' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDA4MDA3NywianRpIjoiYWRiMmI2YzQtODk0Yy00MDBlLWEzMWQtNzZkYjIyZjE3OWU2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6OSwibmJmIjoxNzEwMDgwMDc3LCJjc3JmIjoiZmY3ZDI0ODctYTIxNS00OTRhLTliZTItNGJkMDgzMjZjN2IwIiwiZXhwIjoxNzEwMDgzNjc3fQ.qtWC65D6vrQVSmi1L5BpDuR52H5Fhkop370jWsSe8Js' \
  -H 'Content-Type: application/json' \
  -d '{
  "old_password": "admin",
  "password": "admin123"
}'
    */
    var url = Uri.parse('http://nutrizoom.site/api/auth/change_password');

    var response = await http.post(url,
      headers: {
        "accept": "application/json",
        "Authorization" : "Bearer $bearerToken"
      },
      body: jsonEncode({
        "old_password": oldPassword,
        "password": newPassword
      })
    );

    return response.statusCode;
  }

  Future changeUserData(String name, String email, String username, String birth, String bearerToken) async{
    /*
      curl -X 'POST' \
  'http://nutrizoom.site/api/auth/update_user_data' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDA4MDA3NywianRpIjoiYWRiMmI2YzQtODk0Yy00MDBlLWEzMWQtNzZkYjIyZjE3OWU2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6OSwibmJmIjoxNzEwMDgwMDc3LCJjc3JmIjoiZmY3ZDI0ODctYTIxNS00OTRhLTliZTItNGJkMDgzMjZjN2IwIiwiZXhwIjoxNzEwMDgzNjc3fQ.qtWC65D6vrQVSmi1L5BpDuR52H5Fhkop370jWsSe8Js' \
  -H 'Content-Type: application/json' \
  -d '{
  "name": "",
  "email": "",
  "username": "",
  "birth": ""
}'
    */
    var url = Uri.parse('http://nutrizoom.site/api/auth/update_user_data');

    var response = await http.post(url,
      headers: {
        "accept": "application/json",
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
        "Content-Type": "application/json",
        "Authorization" : "Bearer $bearerToken"
      });

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
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
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  final controller = Controller();
  var _token = "";

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

  Future<void> getUserData(String bearerToken) async {
    var result = await controller.getUserData(bearerToken);
    setState(() {
      user = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xff3C6142),
            //     Color.fromRGBO(255, 245, 212, 0.6),
            //     Color.fromRGBO(197, 211, 176, 0.6)
            //   ]),
            color: Color(0xff3C6142),
          ),

          //atas
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                      weight: 10,
                    ),
                    Row(
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
                          margin: EdgeInsets.all(7.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "Akun",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    margin: EdgeInsets.only(top: 7.0, bottom: 30.0),
                  ),

                  CircleAvatar(
                    // margin: EdgeInsets.only(bottom: 30.0),
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/564x/35/04/d5/3504d58d12e46855f9bc0ff191331f8c.jpg"),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    user?.name ?? "Unknown",
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.justify,
                  ),
                  // SizedBox(height: 5,),
                  Text(
                    user?.username ?? "@unknown_user",
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              // ListView(
              // children: <Widget>[
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: const Offset(5.0, 5.0),
                                blurRadius: 20,
                                spreadRadius: 1.0),
                            const BoxShadow(
                                color: Colors.black45,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5,
                                spreadRadius: 1.0)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                // SizedBox(height: 40,),
                                Container(
                                  child: Text(
                                    "Akun",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  padding: EdgeInsets.only(left: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => change_profile()));
                                  },
                                  child: AkunOption(context, "Ubah Profil"),
                                ),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => change_password()));
                                  },
                                  child: AkunOption(context, "Ubah Password")),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                AkunOption(context, "Hitung Nutrisi Harian"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Container(
                                  child: Text(
                                    "Tentang Aplikasi",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // AkunOption(context, "Tentang"),
                                // Divider(
                                //   height: 20,
                                //   thickness: 1,
                                //   indent: 20,
                                //   endIndent: 20,
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => pusatBantuan()));
                                  },
                                  child: AkunOption(context, "Pusat Bantuan")),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                SizedBox(
                                  height: 40,
                                ),

                                Container(
                                  height: 50,
                                  width: 150,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 100.0),
                                  // decoration: BoxDecoration(
                                  //     color: Color(0xff3C6142),
                                  //     borderRadius: BorderRadius.circular(100)),
                                  // child: TextButton(
                                  //   onPressed: () {},
                                  //   child: Text("KELUAR", style: Theme.of(context).textTheme.button,)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
                                    },
                                    child: Text(
                                      "KELUAR",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff3C6142),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 80,
                                ),

                                Container(
                                    // width: 100,
                                    height: 100,
                                    child: Image(image: AssetImage(tLogo))),

                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "v.10 beta",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )))
              // ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector AkunOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
