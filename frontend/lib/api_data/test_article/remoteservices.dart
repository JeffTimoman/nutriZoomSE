import 'dart:convert';

import 'package:bagianjosh/api_data/test_article/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class RemoteService extends ChangeNotifier {
  List<getArticle> _articles = [];
  List<getArticle> get articles {
    return [..._articles];
  }

  var baseUrl = 'http://nutrizoom.site/api/article';

  Future<List<getArticle>> fetchArticle() async {
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
      List<getArticle> loadArticle = [];

      DateFormat newFormat = DateFormat("dd-MM-yyyy HH:mm");

      data['data'].forEach((key, value) {
        print('ppp key=$key, value=$value');

        // data['data'][key].forEach((key, value) {
        //   print('ppp key=$key, value=$value');

        print('value title: ${value['title']}');
        loadArticle.add(getArticle(
          id: int.parse(key),
          title: value['title'],
          content: value['content'].toString(),
          author: value['author'].toString(),
          image: value['image'].toString(),
          publishdate: newFormat.parse(value['publishdate']),
        ));
        // });
      });

      print('Artikel yang keambil: ' + loadArticle.length.toString());
      _articles = loadArticle;
      notifyListeners();
    } catch (e) {
      print('Exception: ' + e.toString());
    }

    return _articles;
  }
}
