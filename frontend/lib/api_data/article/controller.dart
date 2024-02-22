import 'package:bagianjosh/api_data/article/models.dart';
import 'package:bagianjosh/api_data/article/remoteservices.dart';
import 'package:get/get.dart';

class ArticleController extends GetxController {
  final articles = <Article>[].obs;

  @override
  void onInit() {
    getArticle();
    super.onInit();
  }

  void getArticle() async {
    var remoteServices = RemoteServices();
    var fetchedArticles = await remoteServices.getArticle();
    articles.assignAll(fetchedArticles);
  }
}
