import 'dart:convert';
import 'package:bagianjosh/constants/img_strings.dart';
import 'package:bagianjosh/pages/components/MyButton.dart';
import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/constant/img_string.dart';
// import 'package:gabunginfrontend/pages/components/MyButton.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedDate = formatter.format(date);
  return formattedDate;
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerData() async {
    final url = Uri.parse('http://nutrizoom.site/api/auth/register'); // Ganti dengan URL API Anda
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': emailController.text,
        'name': nameController.text,
        'tanggal_lahir': formatDate(DateTime.parse(tanggalLahirController.text)),
        'username': usernameController.text,
        'password': passwordController.text,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Registrasi berhasil!');
    } else {
      print('Gagal melakukan registrasi. Kesalahan: ${response.statusCode}');
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
                  Image(
                    image: AssetImage(tLogo),
                    width: 200,
                    height: 142.49,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'DAFTAR',
                    style: Theme.of(context).textTheme.headline1
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E-mail',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'milenjoe@email.com',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nama',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'milen joel',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tanggal Lahir',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: tanggalLahirController,
                    decoration: InputDecoration(
                      hintText: 'DATE',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    obscureText: false,
                    onTap: () {
                      selectDate(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'bygumJoe',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kata Sandi',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'masukan password disini',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 50),
                  MyButton(onTap: registerData),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        tanggalLahirController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
