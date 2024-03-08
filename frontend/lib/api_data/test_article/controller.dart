import 'package:bagianjosh/api_data/test_article/models.dart';
import 'package:get/get.dart';
import 'package:bagianjosh/api_data/test_article/remoteservices.dart';

class ArticleController extends GetxController {
  final article = <getArticle>[].obs;
  @override
  void onInit() {
    iniArticle();
    super.onInit();
  }

  void iniArticle() async {
    var remoteService = RemoteService();
    var fetchDataArticles = await remoteService.fetchArticle();
    article.assignAll(fetchDataArticles);
  }
}
