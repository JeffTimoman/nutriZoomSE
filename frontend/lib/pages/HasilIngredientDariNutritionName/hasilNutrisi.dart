import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/HasilIngredientDariNutritionName/controller.dart';
import 'package:gabunginfrontend/pages/hasil_bahan.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';

class hasilNutrisi extends StatefulWidget {
  final String selectedItem;

  const hasilNutrisi({Key? key, required this.selectedItem}) : super(key: key);

  @override
  State<hasilNutrisi> createState() => _hasilNutrisiState();
}

class _hasilNutrisiState extends State<hasilNutrisi> {
  HasilNutrisiApi articlestate =
      HasilNutrisiApi(name: '', unit: '', id: 0, ingredient: []);
  final controller = Controller1();

  @override
  void initState() {
    super.initState();
    getArticle();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Nutrisi",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        backgroundColor: Color(0xff3C6142),
        // toolbarHeight: 90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TapBar()),
            );
          },
        ),
      ),
      
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bahan Pangan yang kamu cari ',
                        style: Theme.of(context).textTheme.headline2
                      ),
                      TextSpan(
                        text: widget.selectedItem,
                        style: Theme.of(context).textTheme.headline2
                      ),
                      TextSpan(
                        text: ' (per 100 g)',
                        style: Theme.of(context).textTheme.headline2
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 2,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                const SizedBox(height: 10),

                // SizedBox(height: 5,),
                // Garis
                Expanded(
                  child: ListView.builder(
                    itemCount: articlestate.ingredient.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HasilBahan(
                                searchText: articlestate.ingredient[index].name,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 340,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 250, 255, 250),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    offset: Offset(0, 10),
                                    blurRadius: 10,
                                    spreadRadius: -6,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                        articlestate.ingredient[index].image,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        articlestate.ingredient[index].name,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      articlestate.ingredient[index].amount.toString() +
                                          ' g',
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getArticle() async {
    try {
      final result =
          await controller.getIngredientByNutritionName(widget.selectedItem);
      setState(() {
        articlestate = result;
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}

// ListView.builder(
//         itemCount: articlestate.ingredient.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//               leading: Image.network(
//                 articlestate.ingredient[index].image,
//                 width: 50,
//                 height: 50,
//               ),
//               title: Text(articlestate.ingredient[index].name),
//               subtitle:
//                   Text(articlestate.ingredient[index].amount.toString()));
//         },
//       ),