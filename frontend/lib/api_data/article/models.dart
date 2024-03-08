import 'dart:convert';
import 'package:intl/intl.dart';

class Article {
  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.image,
    required this.publishdate,
  });

  final int id;
  final String title;
  final String content;
  final String author;
  final String image;
  final DateTime publishdate;

  factory Article.fromJson(Map<String, dynamic> json) {
    Article loadedArticles = Article(
      id: 0,
      title: '',
      content: '',
      author: '',
      image: '',
      publishdate: DateTime.now(),
    );
    if (json['data'] == null) {
      return ('There is no data from this API!') as Article;
    }

    return loadedArticles;
    // return Article(
    //   id: int.parse(json['id']),
    //   title: json['title'].toString(),
    //   content: json['content'].toString(),
    //   author: json['author'].toString(),
    //   image: json['image'].toString(),
    //   publishdate: DateTime.parse(json['publishdate']),
    // );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'author': author,
        'image': image,
      };
}
