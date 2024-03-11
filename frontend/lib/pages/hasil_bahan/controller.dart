import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
{
  "data": {
    "id": 7,
    "name": "Soy_Sauce",
    "representation": "Nutrition from Soy_Sauce per 100 gr",
    "description": "This is a soy sauce",
    "nutrition": {
      "1": {
        "id": 1,
        "name": "Protein",
        "amount": 10,
        "unit": "g"
      },
      "2": {
        "id": 2,
        "name": "Karbohidrat",
        "amount": 10,
        "unit": "g"
      },
      "4": {
        "id": 4,
        "name": "Gula",
        "amount": 10,
        "unit": "g"
      }
    }
  }
}
*/
class Nutrition {
  final int id;
  final String name;
  final double amount;
  final String unit;

  Nutrition({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
    );
  }

  @override
  String toString() {
    return 'id: $id, name: $name, amount: $amount, unit: $unit';
  }
}

class HasilBahanApi {
  final int id;
  final String name;
  final String representation;
  final String image;
  final String description;
  final List<Nutrition> nutrition;

  HasilBahanApi({
    required this.id,
    required this.name,
    required this.representation,
    required this.image,
    required this.description,
    required this.nutrition,
  });

  factory HasilBahanApi.fromJson(Map<String, dynamic> json) {
    List<Nutrition> nutritions = [];
    Map<String, dynamic> nutritionMap = json['data']['nutrition'];

    nutritionMap.forEach((key, value) {
      nutritions.add(Nutrition.fromJson(value));
    });

    return HasilBahanApi(
      id: json['data']['id'],
      name: json['data']['name'],
      image: json['data']['image'],
      representation: json['data']['representation'],
      description: json['data']['description'],
      nutrition: nutritions,
    );
  }

  @override
  String toString() {
    return 'id: $id, name: $name, representation: $representation, description: $description, nutrition: $nutrition';
  }
}

class Controller {
  static Future<HasilBahanApi> fetchHasilNutrisiApi(String name) async {
    var url = "http://nutrizoom.site/api/ingredient/shownutrition/$name";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var hasilNutrisiApi = HasilBahanApi.fromJson(json.decode(response.body));
      return hasilNutrisiApi;
    } else {
      throw Exception('Failed to load hasilNutrisiApi');
    }
  }
}