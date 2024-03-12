import 'dart:convert';
import 'package:http/http.dart' as http;
/*
{
  "data": {
    "2": {
      "recipe_id": 2,
      "recipe_name": "Tempe asik",
      "cooktime": 30,
      "steps": 3,
      "portions": 5,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/acd79b7b-cc61-4434-94aa-02a047c80f16.png",
      "amount": 0.57,
      "unit": "g",
      "total_calory": 0
    },
    "3": {
      "recipe_id": 3,
      "recipe_name": "Tempe Bacem",
      "cooktime": 20,
      "steps": 2,
      "portions": 5,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/c0bfb61e-f732-4dde-a563-87a085917ced.png",
      "amount": 0,
      "unit": "g",
      "total_calory": 0
    },
    "4": {
      "recipe_id": 4,
      "recipe_name": "Tempe Goreng",
      "cooktime": 15,
      "steps": 1,
      "portions": 25,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/55f150d2-808b-469e-b0bc-0bdfb3063bd6.png",
      "amount": 0.03,
      "unit": "kg",
      "total_calory": 0
    },
    "5": {
      "recipe_id": 5,
      "recipe_name": "Masakan 1",
      "cooktime": 30,
      "steps": 10,
      "portions": 3,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/fa9a2bce-78b8-493e-a87c-7ec18a3169b9.png",
      "amount": 15,
      "unit": "ml",
      "total_calory": 0
    }
  }
}
*/
class Recipe{
  final int id;
  final String name;
  final String cooktime;
  final int steps;
  final double portions;
  final String difficulty;
  final String image;
  final double amount;
  final String unit;
  final int totalCalory;

  Recipe({
    required this.id,
    required this.name,
    required this.cooktime,
    required this.steps,
    required this.portions,
    required this.difficulty,
    required this.image,
    required this.amount,
    required this.unit,
    required this.totalCalory,
  });
}

class HasilRecipeApi{
  final List<Recipe> recipes;

  HasilRecipeApi({
    required this.recipes,
  });

  factory HasilRecipeApi.fromJson(Map<String, dynamic> json){
  List<Recipe> recipes = [];
  Map<String, dynamic> data = json['data'];

    data.forEach((key, value) {
      recipes.add(Recipe(
        id: value['recipe_id'],
        name: value['recipe_name'],
        cooktime: value['cooktime'].toString(),
        steps: value['steps'],
        portions: value['portions'].toDouble(), // Convert to double
        difficulty: value['difficulty'].toString(),
        image: value['image'],
        amount: value['amount'].toDouble(), // Convert to double
        unit: value['unit'],
        totalCalory: value['total_calory'], // No need to convert
      ));
    });

    return HasilRecipeApi(
      recipes: recipes,
    );
  }
}

class Controller{
  Future<HasilRecipeApi> fetchFavoriteRecipe(String bearerToken){
    /* 
      curl -X 'GET' \
  'http://nutrizoom.site/api/recipe/show_favorite_recipe' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDE0NzQxMywianRpIjoiN2I4YmMzZDMtYjBhZS00NmViLWI5NjAtMzViNzNhZmEwZWRlIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMTQ3NDEzLCJjc3JmIjoiZmY4NTZiZjUtYjhkZi00ZDI0LWJmNWItYzAzY2YyYzlhNTFlIiwiZXhwIjoxNzEwMTUxMDEzfQ.z8rEplP2N9ZG2mnPfjLNAMTqy3FpklJzKGrHDKrosRA'
    */
    var url = Uri.parse('http://nutrizoom.site/api/recipe/show_favorite_recipe');
    var response = http.get(url, headers: {
      "accept": "application/json",
      "Content-Type" : "application/json",
      "Authorization" : "Bearer $bearerToken"
    });
    response.then((value){
      print(jsonDecode(value.body));
    });
    return response.then((value){
      if (value.statusCode == 200){
        var data = jsonDecode(value.body);
        return HasilRecipeApi.fromJson(data);
      } else {
        throw Exception("Failed to load data");
      }
    });
  } 
}