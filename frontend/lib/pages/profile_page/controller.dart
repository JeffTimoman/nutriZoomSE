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