import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:gabunginfrontend/pages/Article_Home/article_homelist.dart' as ControllerAr;
import 'package:gabunginfrontend/pages/artikel.dart';
import 'package:gabunginfrontend/pages/artikel_page.dart';
import 'package:gabunginfrontend/pages/profile_page/controller.dart';
// import 'package:gabunginfrontend/Alen/profile_page/controller.dart';
// import 'package:gabunginfrontend/pages/Alen/profile_page.dart/controller.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';
import 'package:gabunginfrontend/pages/utility/sharedPreferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  User? user;
  final controller = Controller12();
  final controller2 = Controller2();
  late var _token = "";
  // var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDE3MzQ3MCwianRpIjoiMGIwMDE1MzQtMzQ4Zi00M2NlLTk4NjgtYTE3OWI4NDBlY2Y1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMTczNDcwLCJjc3JmIjoiNTVhYWU4NDUtOTg4Zi00NmNjLWFkNmUtZDFkODhlZjJmMjM0IiwiZXhwIjoxNzQxNzA5NDcwfQ.DIvB3DmFa0U-KiHqEXJf_b4Kr1M978YGPdFhg5t4Pwg";
  late Future<HasilRecipeApi> favoriteRecipes;

  ControllerAr.HasilArticleApi articleState = ControllerAr.HasilArticleApi(
    total_pages: 0,
    current_page: 0,
    per_page: 0,
    total_items: 0,
    articles: [],
  );

  final controller_article = ControllerAr.ControllerArt();

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context).then((token) {
      print('Ini Token: $token');
      if (token != null) {
        setState(() {
          _token = token;
        });
        getUserData(_token!);
      }
    });
    getFavoriteRecipe(_token);
    getArticle();
  }
  // void initState() {
  //   super.initState();
  //   // getUserData(token);
  //   getFavoriteRecipe();
  //   getArticle();
  // }

  Future <void> getFavoriteRecipe(String token) async {
    // var result = await controller2.fetchFavoriteRecipe(bearerToken);
    setState(() {
      favoriteRecipes = controller2.fetchFavoriteRecipe(token);
    });
  }

  Future<void> getUserData(String bearerToken) async {
    var result = await controller.getUserData(bearerToken);
    setState(() {
      user = result;
    });
  }

  Future getArticle() async {
    try {
      final article = await controller_article.fetchHasilArticleApi(1);
      setState(() {
        articleState = article;
      });
    } catch (e) {
      // Handle error
      print('Error fetching articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xff3C6142),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/564x/35/04/d5/3504d58d12e46855f9bc0ff191331f8c.jpg"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo, ${user?.name ?? "Unknown"}",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            "Selamat datang!",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TapBar())),
                      icon: Icon(
                        Icons.search_outlined,
                        size: 30,
                        color: Color(0xff3C6142),
                        shadows: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(2),
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(5.0, 0.0),
                                  blurRadius: 20,
                                  spreadRadius: 0.0),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3,
                                  spreadRadius: 1.0)
                            ]),
                        child: AnotherCarousel(
                          images: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://static.vecteezy.com/system/resources/previews/003/562/296/original/healthy-nutrition-word-concepts-banner-vector.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                ("assets/1.jpg"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                ("assets/2.jpg"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                          dotSize: 4,
                          dotBgColor: Colors.white.withOpacity(0),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Resep Favorit",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 20,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder<HasilRecipeApi>(
                          future: favoriteRecipes,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error: ${snapshot.error}"));
                            } else if (snapshot.hasData) {
                              return Row(
                                children: snapshot.data!.recipes.map((recipe) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ListResep(
                                      recipe_img: recipe.image,
                                      recipe_name: recipe.name,
                                      number_ofCal: recipe.totalCalory,
                                      cooking_time: recipe.cooktime,
                                      portion: recipe.portions,
                                      difficulty: recipe.difficulty,
                                      cooking_step: recipe.steps,
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Center(child: Text(
                                "Kamu belum menambahkan resep favorit apapun!", 
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),);
                            }
                          },
                        ),
                      ),
              
                      SizedBox(height: 20,),
                      Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 8, left: 2),
                      child: Text('Artikel Terkait',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                      SizedBox(height: 20,),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: articleState.articles.length,
                          itemBuilder: (context, index) {
                            var article = articleState.articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArtikelPage(articleId: article.id),
                                  ),
                                );
                              },
                              child: ArticleCard(
                                image: article.image,
                                author: article.author,
                                publishDate: article.publishdate,
                                title: article.title,
                                description: article.content,
                              ),
                            );
                          },
                        ),
                      )
              
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Path: frontend/lib/pages/home.dart
class ListResep extends StatelessWidget {
  final String recipe_img;
  final String recipe_name;
  final int number_ofCal;
  final String cooking_time;
  final double portion;
  final String difficulty;
  final int cooking_step;

  const ListResep(
      {super.key,
      required this.recipe_img,
      required this.recipe_name,
      required this.number_ofCal,
      required this.cooking_time,
      required this.portion,
      required this.difficulty,
      required this.cooking_step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
              height: 120,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // border: Border(
                //   top: BorderSide(
                //     color: Colors.black
                //   )
                // ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3.0, 3.0),
                      spreadRadius: 1.0,
                      blurRadius: 1),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48),
                          child: Image.network(
                            recipe_img,
                            height: 100,
                            width: 120,
                            fit: BoxFit.cover,),
                            // image: AssetImage(Tempe_Img),

                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          recipe_name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Calories
                            Row(
                              children: [
                                Icon(
                                  Icons.fastfood,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  number_ofCal.toString() + ' Kal',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                                // SvgPicture.asset("assets/calories-svgrepo-com.svg", width: 30,)
                              ],
                            ),

                            //cooking time
                            Row(
                              children: [
                                Icon(
                                  Icons.timelapse_outlined,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  cooking_time,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                                // SvgPicture.asset("assets/calories-svgrepo-com.svg", width: 30,)
                              ],
                            ),

                            //porsi
                            Row(
                              children: [
                                Icon(
                                  Icons.person_4_outlined,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  portion.toInt().toString() + ' Porsi',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                                // SvgPicture.asset("assets/calories-svgrepo-com.svg", width: 30,)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //dificulties & step
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xffB8E4B4).withOpacity(0.29),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  difficulty,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xffFF8B5E).withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  cooking_step.toString() + ' Langkah',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}

/*
{
  "data": {
    "2": {
      "recipe_id": 2,
      "recipe_name": "Tempe asik",
      "cooktime": 30,
      "steps": 3,
      "portions": 5,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/acd79b7b-cc61-4434-94aa-02a047c80f16.png",
      "amount": 0.57,
      "unit": "g",
      "total_calory": 0
    },
    "3": {
      "recipe_id": 3,
      "recipe_name": "Tempe Bacem",
      "cooktime": 20,
      "steps": 2,
      "portions": 5,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/c0bfb61e-f732-4dde-a563-87a085917ced.png",
      "amount": 0,
      "unit": "g",
      "total_calory": 0
    },
    "4": {
      "recipe_id": 4,
      "recipe_name": "Tempe Goreng",
      "cooktime": 15,
      "steps": 1,
      "portions": 25,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/55f150d2-808b-469e-b0bc-0bdfb3063bd6.png",
      "amount": 0.03,
      "unit": "kg",
      "total_calory": 0
    },
    "5": {
      "recipe_id": 5,
      "recipe_name": "Masakan 1",
      "cooktime": 30,
      "steps": 10,
      "portions": 3,
      "difficulty": 1,
      "image": "http://nutrizoom.site/view_image/fa9a2bce-78b8-493e-a87c-7ec18a3169b9.png",
      "amount": 15,
      "unit": "ml",
      "total_calory": 0
    }
  }
}
*/
class Recipe{
  final int id;
  final String name;
  final String cooktime;
  final int steps;
  final double portions;
  final String difficulty;
  final String image;
  final double amount;
  final String unit;
  final int totalCalory;

  Recipe({
    required this.id,
    required this.name,
    required this.cooktime,
    required this.steps,
    required this.portions,
    required this.difficulty,
    required this.image,
    required this.amount,
    required this.unit,
    required this.totalCalory,
  });
}

class HasilRecipeApi{
  final List<Recipe> recipes;

  HasilRecipeApi({
    required this.recipes,
  });

  factory HasilRecipeApi.fromJson(Map<String, dynamic> json){
  List<Recipe> recipes = [];
  Map<String, dynamic> data = json['data'];

    data.forEach((key, value) {
      recipes.add(Recipe(
        id: value['recipe_id'],
        name: value['recipe_name'],
        cooktime: value['cooktime'].toString(),
        steps: value['steps'],
        portions: value['portions'].toDouble(), // Convert to double
        difficulty: value['difficulty'].toString(),
        image: value['image'],
        amount: value['amount'].toDouble(), // Convert to double
        unit: value['unit'],
        totalCalory: value['total_calory'], // No need to convert
      ));
    });

    return HasilRecipeApi(
      recipes: recipes,
    );
  }
}

class Controller2 {
  Future<HasilRecipeApi> fetchFavoriteRecipe(String bearerToken) async {
    var url = Uri.parse('http://nutrizoom.site/api/recipe/show_favorite_recipe');
    var response = await http.get(url, headers: {
      "Authorization": "Bearer $bearerToken",
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return HasilRecipeApi.fromJson(data);
    } else {
      // Return predefined data instead of throwing an exception
      var predefinedData = {
        "data": {
          "4": {
            "recipe_id": 4,
            "recipe_name": "Tempe Goreng",
            "cooktime": 15,
            "steps": 4,
            "portions": 10,
            "difficulty": 1,
            "image": "http://nutrizoom.site/view_image/e8c41964-d329-4e0b-9496-755b1d52034f.jpg",
            "amount": 500,
            "unit": "g",
            "total_calory": 0
          },
          "8": {
            "recipe_id": 8,
            "recipe_name": "Ayam Goreng Serundeng",
            "cooktime": 45,
            "steps": 3,
            "portions": 6,
            "difficulty": 2,
            "image": "http://nutrizoom.site/view_image/0f081dab-dbbc-43c3-abec-e29c791e860a.jpg",
            "amount": 1000,
            "unit": "g",
            "total_calory": 8000000
          },
          "9": {
            "recipe_id": 9,
            "recipe_name": "Tempe Bacem",
            "cooktime": 15,
            "steps": 4,
            "portions": 5,
            "difficulty": 1,
            "image": "http://nutrizoom.site/view_image/d49f7840-176e-4d01-abd0-c937be32c25e.png",
            "amount": 250,
            "unit": "g",
            "total_calory": 0
          },
          "10": {
            "recipe_id": 10,
            "recipe_name": "Ayam Fillet Asam Manis",
            "cooktime": 30,
            "steps": 8,
            "portions": 5,
            "difficulty": 1,
            "image": "http://nutrizoom.site/view_image/6352292c-c3b0-48a2-94a3-083143237707.jpg",
            "amount": 10,
            "unit": "g",
            "total_calory": 2000000
          }
        }
      };
      print("Error: ${response.statusCode}");
      return HasilRecipeApi.fromJson(predefinedData);
    }
  }
}