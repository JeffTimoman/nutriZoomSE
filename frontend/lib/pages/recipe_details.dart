import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/Recipe_Details/AddedToFavoAPI.dart';
import 'package:gabunginfrontend/pages/Recipe_Details/recipe_detailsAPI.dart';
import 'package:gabunginfrontend/pages/profile_page/controller.dart';
import 'package:gabunginfrontend/pages/utility/sharedPreferences.dart';

class DetailsRec extends StatefulWidget {
  final int selectedItem;

  const DetailsRec({Key? key, required this.selectedItem}) : super(key: key);

  @override
  State<DetailsRec> createState() => _DetailsRecState();
}

class _DetailsRecState extends State<DetailsRec> {
  User? user;

  late HasilRecipeApi hasilRecipeApi = HasilRecipeApi(id: 0, name: "", steps: [], cooktime: 0, portions: 0, difficulty: "", image: "", ingredients: [], nutritionList: []);
  var _token = "";

  final controller = Controller();
  final conLog = Controller12();
  
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
    getRecipe();
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            hasilRecipeApi.image.isEmpty ? const Center(child: CircularProgressIndicator(),) :
            SizedBox(
              height: 350,
              child: Image.network(
                hasilRecipeApi.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 250,
              left: 20,
              child: Container(
                width: 50,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                    ),
                child: favoriteButton()
              ),
            ),
            buttonArrow(context),
            scroll(),
          ],
        ),
      )
    );
  }

  @override
  

  Future<void> getRecipe() async {
    final hasil = await controller.fetchHasilRecipeApi(widget.selectedItem);
    setState(() {
      hasilRecipeApi = hasil;
    });
  }

  Future<void> getUserData(String bearerToken) async {
    var result = await conLog.getUserData(bearerToken);
    setState(() {
      user = result;
    });
  }

  buttonArrow(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },       
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.7)
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded, 
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll(){
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController){
        return Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),

                // Nama Resep
                Text(hasilRecipeApi.name,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                
                // Jumlah like
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Icon(Icons.favorite,
                //     color: Colors.red,),
                //     // Spacer(),
                //     Text("120 Likes"),
                //   ],
                // ),
                
                // Preparasi dan Porsi
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 45),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffB8E4B4).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: [
                          //   BoxShadow(
                          //     // blurRadius: 10,
                          //     color: Colors.black26,
                          //     offset: Offset(2, 3),
                          //     spreadRadius: 1
                          //   )
                          // ]
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.timer_rounded),
                              Text("${hasilRecipeApi.cooktime} Menit", style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        ),
                      )
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 45),
                        decoration: BoxDecoration(
                          color: Color(0xffB8E4B4).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.people_alt_rounded),
                              Text("${hasilRecipeApi.portions.toInt().toString()} Porsi", style: TextStyle(color: Colors.black),)
                          ],
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                // Bahan
                Text("Bahan", style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(height: 10,),
                // List Bahan
                layoutIngredientsList(context, hasilRecipeApi.ingredients),
            
                SizedBox(height: 10,),
                
                // Steps
                Text("Langkah Memasak", style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(height: 10,),
                // List Steps
                layoutStepsList(context, hasilRecipeApi.steps),
              ]),
            ),
          ),
        );
      }
    );
  }
  
  Widget layoutIngredientsList(BuildContext context, List<Ingredient> ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients.map((ingredient) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(ingredient.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(ingredient.name, style: Theme.of(context).textTheme.bodyText2,),
                  ),
                  Spacer(),
                  Text(ingredient.amount.toString(), style: Theme.of(context).textTheme.bodyText2,),
                  SizedBox(width: 10,),
                  // Spacer(),
                  Text(ingredient.unit, style: Theme.of(context).textTheme.bodyText2,)
                ],
              ),
              Divider(
                height: 15,
              ),
              SizedBox(height: 5),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget layoutStepsList(BuildContext context, List<String> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.map((step) {
        return Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff3C6142),
                    radius: 12,
                    child: Text("${steps.indexOf(step) + 1}", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      step,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,)
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Favprite Button
class favoriteButton extends StatefulWidget {
  const favoriteButton({super.key});

  @override
  State<favoriteButton> createState() => _favoriteButtonState();
}

class _favoriteButtonState extends State<favoriteButton> {
  Controller1 controller = Controller1();
  bool isFavorite = false;

  Future <void> clickFavorite(int id, String bearerToken) async{
    // if (isFavorite){
    //   var result = await controller.removeRecipeToFavorites(id, bearerToken);
    //   if (result == 200){
    //     setState(() => isFavorite = !isFavorite);
    //   }
    // } else {
    //   var result = await controller.addRecipeToFavorites(id, bearerToken);
    //   if (result == 200){
    //     setState(() => isFavorite = !isFavorite);
    //   }
    // }
    var result = await controller.addRecipeToFavorites(id, bearerToken);
    if (result == 200){
      setState(() => isFavorite = !isFavorite);
      return;
    }else{
      result = await controller.removeRecipeToFavorites(id, bearerToken);
      setState(() => isFavorite = !isFavorite);
    }
  }


  @override
  void initState() {
    super.initState();
    setUpIsFav();  
  }

  void setUpIsFav() async {
    isFavorite = await controller.isFavorited(2, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDE2NDA5OSwianRpIjoiY2YzZDFkMDktZmJjOS00ZDcyLWJlZTYtNjkwOGFhNGEwMGU2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMTY0MDk5LCJjc3JmIjoiYWFlMzg3MGMtMjA3Mi00YjE2LTlmNDctNmIxOTM0ZGEwYjY4IiwiZXhwIjoxNzQxNzAwMDk5fQ.IAlxhJSdoNLa9BXNxdHeD70LD-3Zvuw9CW0C2eRLxNQ");  
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          clickFavorite(2, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDE2NDA5OSwianRpIjoiY2YzZDFkMDktZmJjOS00ZDcyLWJlZTYtNjkwOGFhNGEwMGU2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMTY0MDk5LCJjc3JmIjoiYWFlMzg3MGMtMjA3Mi00YjE2LTlmNDctNmIxOTM0ZGEwYjY4IiwiZXhwIjoxNzQxNzAwMDk5fQ.IAlxhJSdoNLa9BXNxdHeD70LD-3Zvuw9CW0C2eRLxNQ");
        });

        if (isFavorite){
          showDialog(
          context: context, 
          builder: (context) => Container(
            // color: Colors.white,
            child: AlertDialog(
              // title: Text("shsis"),
              backgroundColor: Colors.white,
              content: 
              Container(
                // color: Colors.white,
                // margin: EdgeInsets.all(50),
                height: 365,
                child: Column(
                  children: [
                    Container(height: 10),
                    SizedBox(
                      height: 180,
                      child: Image.asset('assets/popup_fav.png')),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        "Resep berhasil ditambahkan ke favorit!",
                        softWrap: true,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.headline2,
                        // TextStyle(
                        //   fontSize: 22,
                        //   fontWeight: FontWeight.w600,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      // padding: EdgeInsets.only(top: 20),
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xff3C6142),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () { 
                          Navigator.pop(context);
                        }, 
                        child: Text("Close",
                          style: Theme.of(context).textTheme.button ,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
          );
        };
      }, 
      icon: Icon(
        !isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        color: !isFavorite ? Colors.red : null,
        // Icons.favorite_outline_rounded
      ),

    );
  }

}


