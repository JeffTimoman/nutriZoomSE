/*
{
  "name": "Protein",
  "unit": "g",
  "id": 1,
  "ingredient": {
    "4": {
      "name": "Tempe",
      "description": "Tempe adalah olahan dari kacang kedelai yang enak dan bergiji",
      "id": 4,
      "image": "http://nutrizoom.site/view_image/375fb49a-243d-4cf6-81be-40b5707776ea.png",
      "amount": 25
    },
    "5": {
      "name": "Bacem",
      "description": "Bacem",
      "id": 5,
      "image": "http://nutrizoom.site/view_image/e22bb62a-7621-4ae8-a457-144f31dde089.png",
      "amount": 50
    },
    "6": {
      "name": "Dada Ayam",
      "description": "Dada",
      "id": 6,
      "image": "http://nutrizoom.site/view_image/db7ebedc-00f2-462f-8de6-443be1d9d526.png",
      "amount": 25
    },
    "7": {
      "name": "Soy_Sauce",
      "description": "This is a soy sauce",
      "id": 7,
      "image": "http://nutrizoom.site/view_image/004b0921-f413-4bea-b691-de26ae30a196.jpg",
      "amount": 10
    }
  }
}
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:learn_api_flutter/model/nutrition.dart';
class Ingredient {
  final int id;
  final String name;
  final String description;
  final String image;
  final double amount;

  Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.amount,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      amount: json['amount'],
    );
  }

  @override
  String toString() {
    return 'id: $id, name: $name, description: $description, image: $image, amount: $amount';
  }
}

class HasilNutrisiApi {
  final String name;
  final String unit;
  final int id;
  final List<Ingredient> ingredient;

  HasilNutrisiApi({
    required this.name,
    required this.unit,
    required this.id,
    required this.ingredient,
  });

  factory HasilNutrisiApi.fromJson(Map<String, dynamic> json) {
    var ingredientMap = json['ingredient'] as Map<String, dynamic>;
    List<Ingredient> ingredientList = ingredientMap.values
        .map((e) => Ingredient.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return HasilNutrisiApi(
      name: json['name'],
      unit: json['unit'],
      id: json['id'],
      ingredient: ingredientList,
    );
  }
}

class Controller1 {
  Future<HasilNutrisiApi> getIngredientByNutritionName(final String name) async {
    var url = "http://nutrizoom.site/api/nutrition/showingredients/$name";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var hasil = HasilNutrisiApi.fromJson(data);
      print(hasil.ingredient);
      return hasil;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
