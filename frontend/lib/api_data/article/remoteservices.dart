import 'package:bagianjosh/api_data/article/models.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RemoteServices extends ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles {
    return [..._articles];
  }

  var baseUrl = 'http://nutrizoom.site/api/article';

  Future<List<Article>> getArticle() async {
    var url = Uri.parse('$baseUrl/get_articles');
    var headers = {
      'content-type': 'application/json',
    };
    try {
      var response = await http.get(
        url,
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (data['data'] == null) {
        return _articles;
      }
      List<Article> loadedArticles = [];
      DateFormat newFormat = DateFormat("dd-MM-yyyy HH:mm");
      data['data'].forEach((key, value) {
        // print('Key: $key, Value: $value');
        loadedArticles.add(Article(
          id: int.parse(key),
          title: value['title'],
          content: value['content'],
          author: value['author'],
          image: value['image'],
          publishdate: newFormat.parse(value['publishdate']),
        ));
      });
      print('panjangnya: ' + loadedArticles.length.toString());
      _articles = loadedArticles;
      notifyListeners();
    } catch (e) {
      print('Exception di Remote Services: ' + e.toString());
    }
    return _articles; // Add this line
  }
}
