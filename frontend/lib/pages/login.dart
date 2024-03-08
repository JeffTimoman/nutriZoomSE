import 'package:bagianjosh/constants/img_strings.dart';
import 'package:bagianjosh/pages/components/MyButton.dart';
import 'package:bagianjosh/pages/register.dart';
import 'package:bagianjosh/pages/resep.dart';
import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/constant/img_string.dart';
// import 'package:gabunginfrontend/pages/components/MyButton.dart';
// import 'package:gabunginfrontend/pages/register.dart';
// import 'package:gabunginfrontend/pages/resep.dart';
import 'package:http/http.dart' as http;


class loginpage extends StatelessWidget {
  // Text editing controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to handle sign in
  Future<void> signInUser(BuildContext context) async {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse("http://nutrizoom.site/api/auth/login"),
        body: {
          "email": usernameController.text,
          "password": passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => resepPage()));  // ke RESEP KARENA BELUM ADA HOMENYA
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Email or Password.")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Insert Email and Password.")));
    }
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
                  MyButton(onTap: () => signInUser(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
