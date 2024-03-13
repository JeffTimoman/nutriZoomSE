import 'package:flutter/material.dart';
import 'package:gabunginfrontend/constants/img_strings.dart';
import 'package:gabunginfrontend/pages/bottom_nav.dart';
import 'package:gabunginfrontend/pages/home.dart';
import 'package:gabunginfrontend/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}


class _loginPageState extends State<loginPage> {
  // Text editing controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to handle sign in
  Future<void> signInUser(BuildContext context) async {
    print('This works');
    final String apiUrl = 'http://nutrizoom.site/api/auth/login';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          // 'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": usernameController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successful login
        final token = jsonDecode(response.body)['access_token'];
        // final userData = jsonDecode(response.body);
        // final username = jsonDecode(response.body)['access_token'];
        // final usernameA = userData['username'];
        // final nameA = userData['name'];
        // print(usernameA);
        // print(nameA);


        // Store the token using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        print('Cek Token: $token');
        // prefs.setString('username', usernameA); // Store the username
        // prefs.setString('name', nameA); // Store the name
      // prefs.setString('name', usernameController);
      // prefs.setString('username', username);
        
        // Navigate to ProfilePage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Email or Password.")));
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again later.")));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.setMockInitialValues({});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Logo NutriZoom
                  const Image(
                    image: AssetImage(tLogo),
                    width: 200,
                    height: 142.49,
                  ),
                  const SizedBox(height: 20),
                  // Solusi Nutrisimu
                  Text(
                    'MASUK',
                    style: Theme.of(context).textTheme.headline2
                    // TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.black,
                    //   fontSize: 20,
                    // ),
                  ),
                  const SizedBox(height: 30),
                  // Username or Email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username / E-mail',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Username Field
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'milenjoe@email.com',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  // Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kata Sandi',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'masukan password disini',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 80),
                  // Register
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => registerPage()));
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Belum Mendaftar? ',
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Daftar',
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Login Button
                  InkWell(
                    onTap: () => signInUser(context),
                    child: Container(
                      width: 154,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Color(0xff3C6142),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(
                          "MASUK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),

                  // MyButton(onTap: () => signInUser(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
