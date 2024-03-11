import 'dart:convert';
import 'package:http/http.dart' as http;

class Controller1{
  Future addRecipeToFavorites(int recipeID, String BearerToken) async{
     /*
     curl -X 'POST' \
      'http://nutrizoom.site/api/recipe/add_favorite_recipe/2' \
      -H 'accept: application/json' \
      -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDA3NjI0MCwianRpIjoiNzA5MjQ0YTgtNzNmNy00NTNkLWI5NjUtZDE3OTQ1OTYyOWMwIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMDc2MjQwLCJjc3JmIjoiM2ZhYzM5Y2YtYzk1NC00NTZlLWFmOTYtYWQwNTQ4MDAyYTJjIiwiZXhwIjoxNzEwMDc5ODQwfQ.bfpev1wE8OxZO5dkNfrPb9PFqmaTZXXNQnBxO0EWUos' \
      -d ''
     */
    var url = Uri.parse('http://nutrizoom.site/api/recipe/add_favorite_recipe/$recipeID');
    var response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $BearerToken',
      },
    );

    // return response.statusCode;
  }

  Future removeRecipeToFavorites(int recipeID, String BearerToken) async{
    /*
    curl -X 'POST' \
  'http://127.0.0.1:5000/api/recipe/remove_from_favourites/5' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDA3NjM5MiwianRpIjoiYTVlYWFlMDctZDg2OC00ODU0LTk5ZGUtMjM0MmMzZDdmNzAwIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMDc2MzkyLCJjc3JmIjoiMWQwNGZjMmItZGMwYS00ZDY5LWIzZDYtODkwNDFiMzJmNGQ0IiwiZXhwIjoxNzEwMDc5OTkyfQ.GhrigIp2K35A7brGr-hQ-A-DgybS551aZHtXde1jv-4' \
  -d ''
    */
    var url = Uri.parse('http://nutrizoom.site/api/recipe/remove_from_favourites/$recipeID');
    var response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $BearerToken',
      },
    );
    print(response.statusCode);
    return response.statusCode;
  }

  Future isFavorited(int recipeID, String bearerToken) async{
    /*
      curl -X 'GET' \
  'http://nutrizoom.site/api/recipe/is_favorite/2' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDA4MzE2OSwianRpIjoiYjA1YjFiMjgtMjRmZC00MTIxLWExZjYtNGY2ZGJlOTc0NjM0IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMDgzMTY5LCJjc3JmIjoiZjIwY2FlMTItMTdkOC00NWE1LWI3NDctOTA2ZGM1NmE1ZTg1IiwiZXhwIjoxNzEwMDg2NzY5fQ.OhXuozdCW9B48VOXgQM9jXcS8hu4FWBjcos8oN2UQ2c'
    */
    print("This works");
    var url = Uri.parse('http://nutrizoom.site/api/recipe/is_favorite/$recipeID');
    var response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200){
      return false;
    }
    return true;
  }
} 