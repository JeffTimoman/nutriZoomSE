class Article {
  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
  });

  final int id;
  final String title;
  final String content;
  final String author;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'author': author,
      };
}
