import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/Alen/list_resep/controller.dart';
import 'package:gabunginfrontend/pages/listResep_tile.dart';
import 'package:gabunginfrontend/pages/list_resep/controller.dart';

class ListResepPage extends StatefulWidget {
  final String judul_page;
  const ListResepPage({super.key, required this.judul_page});

  @override
  State<ListResepPage> createState() => _ListResepPage();
}

class _ListResepPage extends State<ListResepPage>{
  HasilRecipeApi? hasilRecipeApi;
  final controller = Controller();

  late String pageTitle;

  @override
  void initState(){
    super.initState();
    pageTitle = widget.judul_page;
    fetchApiRecipeByIngredientNameClosest(pageTitle);
  }

  Future <void> fetchApiRecipeByIngredientNameClosest(String name) async {
    var result = await controller.fetchApiRecipeByIngredientNameClosest(name);
    setState(() {
      hasilRecipeApi = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   items:[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),

      //   ]
      // ),
        // backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Color(0xff3C6142),
          title: Text(
            "Resep " + pageTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          leading: IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
              weight: 10,
              )
          )
          
          // Container(
          //   margin: EdgeInsets.all(18),
          //   child: InkWell(
          //     child: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.white,
          //       size: 20,
          //       weight: 10,
          //     ),
          //   ),
          // ),
        ),

        // LIST VIEW DAFTAR HASIL RESEP
        body: Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 5),
            child: Expanded(
                child: hasilRecipeApi == null ? Center(child: CircularProgressIndicator()) : ListView.builder(
                  itemCount: hasilRecipeApi!.recipes.length,
                  itemBuilder: (context, index){
                    return ListResep(
                      recipe_img: hasilRecipeApi!.recipes[index].image, 
                      recipe_name: hasilRecipeApi!.recipes[index].name, 
                      number_ofCal: hasilRecipeApi!.recipes[index].totalCalory, 
                      cooking_time: hasilRecipeApi!.recipes[index].cooktime, 
                      portion: hasilRecipeApi!.recipes[index].portions, 
                      difficulty: hasilRecipeApi!.recipes[index].difficulty, 
                      cooking_step: hasilRecipeApi!.recipes[index].steps);
                  })
                // ListView(
                //   children: [
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 280,
                //       cooking_time: "15:00",
                //       portion: 4,
                //       difficulty: "Easy",
                //       cooking_step: 6,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 280,
                //       cooking_time: "12:00",
                //       portion: 4,
                //       difficulty: "Easy",
                //       cooking_step: 8,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 350,
                //       cooking_time: "15:00",
                //       portion: 8,
                //       difficulty: "Easy",
                //       cooking_step: 6,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Apa",
                //       number_ofCal: 280,
                //       cooking_time: "15:00",
                //       portion: 4,
                //       difficulty: "Hard",
                //       cooking_step: 6,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 278,
                //       cooking_time: "15:00",
                //       portion: 10,
                //       difficulty: "Easy",
                //       cooking_step: 3,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 278,
                //       cooking_time: "15:00",
                //       portion: 10,
                //       difficulty: "Easy",
                //       cooking_step: 3,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 278,
                //       cooking_time: "15:00",
                //       portion: 10,
                //       difficulty: "Easy",
                //       cooking_step: 3,
                //     ),
                //     ListResep(
                //       recipe_img: AssetImage(Tempe_Img),
                //       recipe_name: "Tempe Orek",
                //       number_ofCal: 278,
                //       cooking_time: "15:00",
                //       portion: 10,
                //       difficulty: "Easy",
                //       cooking_step: 3,
                //     ),

                //   ],
                // )
                
                ),
          ),
        ));
  }

}
  
  

