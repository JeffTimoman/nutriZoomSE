import 'package:bagianjosh/api_data/Models/models.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoteServices extends ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles {
    return [..._articles];
  }

  var baseUrl = 'https://65d549733f1ab8c63436ae8e.mockapi.io/api/article';

  Future<List<Article>> getArticle() async {
    var url = Uri.parse('$baseUrl/get_articles/articles');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        return _articles;
      }
      final List<Article> loadedArticles = [];
      extractedData.forEach((data) {
        loadedArticles.add(Article(
            id: int.parse(data['id']),
            title: data['title'],
            content: data['content'],
            author: data['author']));
      });
      print(loadedArticles.length);
      _articles = loadedArticles;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return _articles; // Add this line
  }
}
