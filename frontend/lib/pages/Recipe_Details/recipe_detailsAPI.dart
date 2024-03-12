import 'dart:convert';
import 'package:http/http.dart' as http;

class Ingredient {
  final double amount;
  final String name;
  final String image;
  final String unit;
  final int id;

  Ingredient({
    required this.amount,
    required this.image,
    required this.name,
    required this.unit,
    required this.id,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      amount: json['amount'],
      image: json['image'],
      name: json['name'],
      unit: json['unit'],
      id: int.parse(json['id']),
    );
  }
}

class Nutrition {
  final String name;
  final double amount;
  final String unit;
  final int id;

  Nutrition({
    required this.name,
    required this.amount,
    required this.unit,
    required this.id,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
      id: int.parse(json['id']),
    );
  }
}

class HasilRecipeApi {
  final int id;
  final String name;
  final List <String> steps;
  final int cooktime;
  final double portions;
  final String difficulty;
  final String image;
  final List<Ingredient> ingredients;
  final List<Nutrition> nutritionList;

  HasilRecipeApi({
    required this.id,
    required this.name,
    required this.steps,
    required this.cooktime,
    required this.portions,
    required this.difficulty,
    required this.image,
    required this.ingredients,
    required this.nutritionList,
  });

  factory HasilRecipeApi.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> ingredientsData = json['ingredients'];
    final List<Ingredient> ingredients = ingredientsData.entries.map((e) {
      final Map<String, dynamic> ingredientData = e.value;
      return Ingredient.fromJson({
        ...ingredientData,
        'id': e.key,
      });
    }).toList();

    final Map<String, dynamic> nutritionListData = json['nutrition_list'];
    final List<Nutrition> nutritionList = nutritionListData.entries.map((e) {
      final Map<String, dynamic> nutritionData = e.value;
      return Nutrition.fromJson({
        ...nutritionData,
        'id': e.key,
      });
    }).toList();
    var steps = json['steps'];
    List <String> stepsList = steps.split('\n');
    // for each string in stepsList, remove <p> and </p> and replace &nbsp; with space, rstrip and lstrip 
    for (var i = 0; i < stepsList.length; i++) {
      stepsList[i] = stepsList[i].replaceAll('<p>', '').replaceAll('</p>', '').replaceAll('&nbsp;', ' ').trim();
    }
    
    return HasilRecipeApi(
      id: json['id'],
      name: json['name'],
      steps: stepsList,
      cooktime: json['cooktime'],
      portions: json['portions'],
      difficulty: json['difficulty'],
      image: json['image'],
      ingredients: ingredients,
      nutritionList: nutritionList,
    );
  }
}

class Controller {
  Future<HasilRecipeApi> fetchHasilRecipeApi(int id) async {
    var response = await http.get(Uri.parse('http://nutrizoom.site/api/recipe/find_recipe_id/$id'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = HasilRecipeApi.fromJson(data['data']);
      return result;
    } else {
      throw Exception('Failed to load recipe');
    }
  }
}