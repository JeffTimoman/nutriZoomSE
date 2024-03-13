import 'dart:convert';
import 'package:http/http.dart' as http;

class Article {
  final int id;
  final String title;
  final String content;
  final String author;
  final String created_by;
  final String publishdate;
  final String image;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.created_by,
    required this.publishdate,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'].replaceAll('<p>', '')
          .replaceAll('</p>', '\n')
          .replaceAll('&nbsp;', ' '),
      author: json['author'],
      created_by: json['created_by'],
      publishdate: json['publishdate'],
      image: json['image'],
    );
  }

  @override
  String toString() {
    return 'id: $id, title: $title, content: $content, author: $author, created_by: $created_by, publishdate: $publishdate, image: $image';
  }
}

class HasilArticleApi {
  final int total_pages;
  final int current_page;
  final int per_page;
  final int total_items;
  final List<Article> articles;

  HasilArticleApi({
    required this.total_pages,
    required this.current_page,
    required this.per_page,
    required this.total_items,
    required this.articles,
  });

  factory HasilArticleApi.fromJson(Map<String, dynamic> json) {
    print(json);
    final Map<String, dynamic> data = json['data'];
    final List<Article> articles = data.entries.map((e) {
      final Map<String, dynamic> articleData = e.value;
      return Article.fromJson({
        ...articleData,
        'id': int.parse(e.key),
      });
    }).toList();

    return HasilArticleApi(
      total_pages: json['total_pages'],
      current_page: json['current_page'],
      per_page: json['per_page'],
      total_items: json['total_items'],
      articles: articles,
    );
  }
}


class ControllerArt {
   Future<HasilArticleApi> fetchHasilArticleApi(int page) async {
    var url = "http://nutrizoom.site/api/article/get_articles?page=$page";
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return HasilArticleApi.fromJson(data);
    } else {
      throw Exception('Failed to load article');
    }
  }
}
