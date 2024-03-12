import 'dart:convert';
import 'package:http/http.dart' as http;
/*
{
  "data": {
    "6": {
      "recipe_id": 6,
      "recipe_name": "Babi",
      "cooktime": 20,
      "steps": 3,
      "portions": 20,
      "difficulty": "medium",
      "image": "http://nutrizoom.site/view_image/7198c9bc-7841-489a-a731-ded3cb962800.jpg",
      "amount": 20,
      "unit": "g",
      "total_calory": 8000
    },
    "7": {
      "recipe_id": 7,
      "recipe_name": "Babi Goreng",
      "cooktime": 20,
      "steps": 5,
      "portions": 2,
      "difficulty": "medium",
      "image": "http://nutrizoom.site/view_image/a4021181-6784-4cce-b33f-8ad1e528ac98.jpg",
      "amount": 200,
      "unit": "g",
      "total_calory": 808000
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
        portions: value['portions'],
        difficulty: value['difficulty'],
        image: value['image'],
        amount: value['amount'],
        unit: value['unit'],
        totalCalory: value['total_calory'].toInt(),
      ));
    });

    return HasilRecipeApi(
      recipes: recipes,
    );
  }
}

class Controller{
  Future<HasilRecipeApi> fetchApiRecipeByIngredientNameClosest(String name){
    var url = "http://nutrizoom.site/api/recipe/find_recipe_ingredient/$name";
    var uri = Uri.parse(url);
    return http.get(uri).then((response){
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        return HasilRecipeApi.fromJson(data);
      }else{
        throw Exception('Failed to load data. Error: ${response.statusCode}');
      }
    });
  }
  
}