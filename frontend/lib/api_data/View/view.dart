import 'package:bagianjosh/api_data/Controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleView extends StatelessWidget {
  final ArticleController _controller = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article List'),
      ),
      body: Obx(
        () => _controller.articles.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _controller.articles.length,
                itemBuilder: (context, index) {
                  var article = _controller.articles[index];
                  return ListTile(
                    title: Text(article.author),
                    subtitle: Text(article.content),
                  );
                },
              ),
      ),
    );
  }
}
