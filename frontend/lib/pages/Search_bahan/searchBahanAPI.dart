import 'dart:convert';
import 'package:http/http.dart' as http;

class Nutrition{
  final int id;
  final int amount;
  final String name;
  final String unit;

  Nutrition({
    required this.id,
    required this.amount,
    required this.name,
    required this.unit,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json){
    return Nutrition(
      id: json['id'],
      amount: json['amount'],
      name: json['name'],
      unit: json['unit'],
    );
  }
}
class NutritionApiData {
  final int id;
  final String name;
  final String representation;
  final String description;
  final Map<String, Nutrition> nutrition;

  NutritionApiData({
    required this.id,
    required this.name,
    required this.representation,
    required this.description,
    required this.nutrition,
  });

  factory NutritionApiData.fromJson(Map<String, dynamic> json) {
    Map<String, Nutrition> nutritionMap = {};
    Map<String, dynamic> nutritionData = json['nutrition'];

    nutritionData.forEach((key, value) {
      nutritionMap[key] = Nutrition.fromJson(value);
    });

    return NutritionApiData(
      id: json['id'],
      name: json['name'],
      representation: json['representation'],
      description: json['description'],
      nutrition: nutritionMap,
    );
  }
}


class Controller{
  Future<NutritionApiData> fetchApiNutrition(String name) async {
  var url = Uri.parse('http://nutrizoom.site/api/ingredient/shownutrition/$name');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return NutritionApiData.fromJson(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Failed to load data');
  }
  }
}