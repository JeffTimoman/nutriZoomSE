import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/resep.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:gabunginfrontend/pages/resep.dart';

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

class Controller{
  Future <Article> fetchArticleByID(int id) async{
    final response = await http.get(Uri.parse('http://nutrizoom.site/api/article/show_article/$id'));
    if(response.statusCode == 200){
      return Article.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load article');
    }
  }
}

class artikelPage extends StatefulWidget {
  @override
  _artikelPageState createState() => _artikelPageState();
}
// Update the _artikelPageState class

class _artikelPageState extends State<artikelPage> {
  var controller = Controller();
  var article = Article(
    title: '',
    content: '',
    author: '',
    publishdate: '',
    createdby: '',
    image: '',
  );

  @override
  void initState() {
    super.initState();
    controller.fetchArticleByID(2).then((value) {
      setState(() {
        article = value;
      });
    });
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
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                    )
                  : ErrorWidget('Failed to load image'),
            ),

            DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1.0,
              minChildSize: 0.6,
              builder: (context, ScrollController) {
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
                    controller: ScrollController,
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
                            // ... (existing code)

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
