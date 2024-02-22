class Ingredient {
  Ingredient({
    required this.id,
    required this.name,
    required this.representation,
    required this.decription,
    required this.nutrition{
      required this.calories,
      required this.fat,
      required this.saturatedFat,
      required this.transFat,
      required this.cholesterol,
      required this.sodium,
      required this.carbohydrates,
      required this.fiber,
      required this.sugar,
      required this.protein,
      required this.vitaminD,
      required this.calcium,
      required this.iron,
      required this.potassium,
    },
  });

  final int id;
  final String title;
  final String content;
  final String author;

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
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
