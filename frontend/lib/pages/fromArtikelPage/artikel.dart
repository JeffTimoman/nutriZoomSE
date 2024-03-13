import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/artikel_page.dart';
import 'package:gabunginfrontend/pages/bottom_nav.dart';
import 'package:gabunginfrontend/pages/home.dart';
import 'package:http/http.dart' as http;

class Article {
  final String title;
  final String content;
  final String author;
  final String publishdate;
  final String createdby;
  final String image;

  Article({
    required this.title,
    required this.content,
    required this.author,
    required this.publishdate,
    required this.createdby,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      content: json['content']
          .replaceAll('<p>', '')
          .replaceAll('</p>', '\n')
          .replaceAll('&nbsp;', ' '),
      author: json['author'],
      publishdate: json['publishdate'],
      createdby: json['createdby'],
      image: json['image'],
    );
  }
}

class Controller {
  Future<Article> fetchArticleByID(int id) async {
    final response =
        await http.get(Uri.parse('http://nutrizoom.site/api/article/show_article/$id'));
    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load article');
    }
  }
}

class ArtikelPagePage extends StatefulWidget {
  final int articleId;

  ArtikelPagePage({required this.articleId});

  @override
  _ArtikelPagePageState createState() => _ArtikelPagePageState();
}

class _ArtikelPagePageState extends State<ArtikelPagePage> {
  late final Controller controller;
  late Article article;

  @override
  void initState() {
    super.initState();
    controller = Controller();
    article = Article(
      title: '',
      content: '',
      author: '',
      publishdate: '',
      createdby: '',
      image: '',
    );
    fetchArticle();
  }

  void fetchArticle() async {
    try {
      final fetchedArticle = await controller.fetchArticleByID(widget.articleId);
      setState(() {
        article = fetchedArticle;
      });
    } catch (e) {
      print('Failed to fetch article: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: article.image.isNotEmpty
                  ? Image.network(
                      article.image,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            Container(
              margin: EdgeInsets.all(18),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: 60, // Adjust the width of the circle here
                        height: 60, // Adjust the height of the circle here
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar(currentIndex: 3)), // Replace "Navbar" with the appropriate widget representing your navbar
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1.0,
              minChildSize: 0.6,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(33),
                      topRight: Radius.circular(33),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 9,
                                width: 81,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(Radius.circular(33)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${article.title}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33),
                                  color: Color(0xffEAF7E9),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xffEAF7E9),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xff4D5A4C),
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${article.author}',
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C6142),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33),
                                  color: Color(0xffEAF7E9),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xffEAF7E9),
                                      child: Icon(
                                        Icons.edit_calendar,
                                        color: Color(0xff4D5A4C),
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${article.publishdate}',
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C6142),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Text(
                          '${article.content}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
