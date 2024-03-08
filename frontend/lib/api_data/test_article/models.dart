// Ceriitanya ngambil title, author, content

class getArticle {
  //INI SANGAT PERLU DBUAT (1)
  getArticle({
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

  //MASIH TEMPLATE YANG GA GKEPAKE
  // factory getArticle.fromJson(Map<String, dynamic> json) {
  //   return getArticle(

  //     title: json['title'].toString(),
  //     content: json['content'].toString(),
  //     author: json['author'].toString(),
  //     image: json["image"],

  //   );
  // }
}
