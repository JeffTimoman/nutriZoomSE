import 'dart:convert';
import 'package:http/http.dart' as http;

class Nutrition {
  final String name;
  final String unit;
  final int id;

  Nutrition({
    required this.name,
    required this.unit,
    required this.id,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      name: json['name'],
      unit: json['unit'],
      id: int.parse(json['id'].toString()),
    );
  }

  @override
  String toString() {
    return 'name: $name, unit: $unit, id: $id';
  }
}

class DropDownApi {
  final List<Nutrition> nutritionList;

  DropDownApi({
    required this.nutritionList,
  });

  factory DropDownApi.fromJson(Map<String, dynamic> json) {
    List<Nutrition> nutritionList = [];

    json.forEach((key, value) {
      var nutritionData = value as Map<String, dynamic>;
      nutritionList.add(Nutrition.fromJson({
        'name': nutritionData['name'],
        'unit': nutritionData['unit'],
        'id': nutritionData['id'],
      }));
    });

    return DropDownApi(
      nutritionList: nutritionList,
    );
  }
}

class Controller {
  Future<DropDownApi> fetchApiDropDown() async {
    var url = Uri.parse('http://nutrizoom.site/api/nutrition/get_nutrition?page=1&per_page=1000');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      return DropDownApi.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
