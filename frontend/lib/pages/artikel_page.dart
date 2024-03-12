import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gabunginfrontend/pages/Article_Home/article_homelist.dart';
// import 'package:gabunginfrontend/pages/Mirzha/Article_Home/article_homelist.dart';

// class DummyData {
//   static List<Map<String, dynamic>> generateDummyArticles() {
//     return [
//       {
//         'image': 'assets/image/kentang.jpg',
//         'author': 'John Doe',
//         'publishDate': 'January 15, 2024',
//         'title': 'LOREM IPSUM DOLOR SIT AMET',
//         'description' : 'Apa pentingnya nutrisi bagi tubuh manusia, termasuk Anda kaum wanita? Kebanyakan orang pasti tahu jawabannya. Ya betul, keberadaan nutrisi ini dalam tubuh manusia tidak disangsikan lagi memiliki'
//       },
//       {
//         'image': 'assets/image/kentang.jpg',
//         'author': 'Jane Smith',
//         'publishDate': 'February 5, 2024',
//         'title': 'Consectetur Adipiscing Elit',
//         'description' : 'Kentang (Solanum tuberosum L.) adalah salah satu jenis tumbuhan yang bagian akarnya biasanya dimakan sebagai sayuran.'
//       },
//       {
//         'image': 'assets/image/kentang.jpg',
//         'author': 'Bob Johnson',
//         'publishDate': 'March 20, 2024',
//         'title': 'Sed Do Eiusmod Tempor Incididunt Lorem Ipsum Bla Bla Blla',
//         'description' : 'Kentang (Solanum tuberosum L.) adalah salah satu jenis tumbuhan yang bagian akarnya biasanya dimakan sebagai sayuran.'
//       },
//       {
//         'image': 'assets/image/kentang.jpg',
//         'author': 'Alice Williams',
//         'publishDate': 'April 10, 2024',
//         'title': 'Ut Labore Et Dolore Magna Aliqua',
//         'description' : 'Apa pentingnya nutrisi bagi tubuh manusia, termasuk Anda kaum wanita? Kebanyakan orang pasti tahu jawabannya. Ya betul, keberadaan nutrisi ini dalam tubuh manusia tidak disangsikan lagi memiliki'
//       },
//       {
//         'image': 'assets/image/kentang.jpg',
//         'author': 'Charlie Brown',
//         'publishDate': 'May 25, 2024',
//         'title': 'Enim Ad Minim Veniam',
//         'description' : 'Apa pentingnya nutrisi bagi tubuh manusia, termasuk Anda kaum wanita? Kebanyakan orang pasti tahu jawabannya. Ya betul, keberadaan nutrisi ini dalam tubuh manusia tidak disangsikan lagi memiliki'
//       },
//     ];
//   }
// }
class ArticleWidget extends StatefulWidget {
  ArticleWidget({Key? key}) : super(key: key);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  // final List<Map<String, dynamic>> articles;

  // ArticleWidget({required this.articles});

  late HasilArticleApi articleState = HasilArticleApi(
    total_pages: 0,
    current_page: 0,
    per_page: 0,
    total_items: 0,
    articles: [],
  );

  final controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xff3C6142) ,
          title: Text("Artikel",
          style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            )
          ),
          leading: Container(
            margin: EdgeInsets.all(18),
            // alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_outlined,
              size: 20,
              color:Colors.white,
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Artikel Terfavorit Minggu Ini",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.left,
                    ),
                ),
                articleState.articles.isEmpty ? const Center(child: CircularProgressIndicator()):
                CarouselSlider.builder(
                  itemCount: articleState.articles.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    final article = articleState.articles[index];
                    return Builder(
                      builder: (BuildContext context) {
                        return ArticleSlider(
                          image: article.image,
                          author: article.author,
                          publishDate: article.publishdate,
                          title: article.title, 
                        );
                      },
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    autoPlay: false,
                    enlargeCenterPage: true
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 8, left: 2),
                  child: Text('Seputar Nutrisi',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articleState.articles.length,
                    itemBuilder: (context, index) {  
                      var article = articleState.articles[index];
                      return ArticleCard(
                        image: article.image,
                        author: article.author, 
                        publishDate: article.publishdate, 
                        title: article.title,
                        description: article.content,
                      );
                    },
                    // padding: EdgeInsets.only(bottom: 20),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  @override
  initState() {
    super.initState();
    getArticle();
  }

  Future getArticle() async {
    try {
      final article = await controller.fetchHasilArticleApi(1);
      setState(() {
        articleState = article;
      });
    } catch (e) {
      // Handle error
      print('Error fetching articles: $e');
    }
  }
  
}

// Content Slider
class ArticleSlider extends StatelessWidget {
  final String image;
  final String author;
  final String publishDate;
  final String title;

  ArticleSlider({
    required this.image,
    required this.author,
    required this.publishDate,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),

      // Content
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Container(
                height: 110,
                width: 300,
                child: Image.network(image, fit:  BoxFit.cover),
                // width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 20,
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(author, 
                style: TextStyle(fontFamily: "Montserrat", color: Color(0xff1A5D1A), fontWeight: FontWeight.w700, fontSize: 12),
                maxLines: 1,
              ),
            ),
            Container(
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(title,
                style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Content Tanggal dan Icon
            Container(
              padding: EdgeInsets.only(left: 10,),
              height: 20,
              child: Row(
                children: [
                  SizedBox(
                    // height: 0,
                    // width: 30,
                    child: Icon(
                      Icons.date_range
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    width: 180,
                    child: Text('$publishDate',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 5),
                    child: Text('Lihat >>',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ]
        )
      )
    );
  }
} 

// Content Card
class ArticleCard extends StatelessWidget {
  final String image;
  final String author;
  final String publishDate;
  final String title;
  final String description;

  const ArticleCard({
    required this.image, 
    required this.author, 
    required this.publishDate, 
    required this.title, 
    required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 250,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
          )
        ]
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.network(
                image,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 20,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      height: 15,
                      child: Text(
                        '$author | $publishDate',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff181818).withOpacity(0.52),
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Baca selengkapnya',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff1A5D1A),
                        fontWeight: FontWeight.w500,
                        fontSize: 11
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}