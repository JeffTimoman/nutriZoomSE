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
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff3C6142),
        toolbarHeight: 90,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: widget.selectedItem,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: '  (per 100 g)',
                        style: TextStyle(
                          fontSize: 18,
                        ),
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


                // Garis
              //   Container(
              //     height: 2,
              //     color: Colors.grey,
              //     margin: EdgeInsets.symmetric(vertical: 20),
              //   ),
              //   Expanded(
              //     child: ListView.builder(
              //       itemCount: articlestate.ingredient.length,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              //           width: MediaQuery.of(context).size.width,
              //           height: 60,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(15),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black.withOpacity(0.6),
              //                 offset: Offset(
              //                   0.0,
              //                   10.0,
              //                 ),
              //                 blurRadius: 10.0,
              //                 spreadRadius: -6.0,
              //               ),
              //             ],
              //           ),
              //           child: Stack(
              //             children: [
              //               Positioned(
              //                 left: 10,
              //                 top: 10,
              //                 bottom: 10,
              //                 right: 310,
              //                 child: Container(
              //                   width: 210, // Atur lebar gambar sesuai kebutuhan
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.all(Radius.circular(5)),
              //                     image: DecorationImage(
              //                       image: NetworkImage(articlestate.ingredient[index].image),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Positioned(
              //                 left: 80, // Atur jarak antara gambar dan teks
              //                 top: 0,
              //                 bottom: 0,
              //                 right: 0,
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Padding(
              //                     padding: EdgeInsets.symmetric(horizontal: 5.0),
              //                     child: Text(
              //                       articlestate.ingredient[index].name,
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.w600,
              //                         fontSize: 17,
              //                       ),
              //                       overflow: TextOverflow.ellipsis,
              //                       maxLines: 2,
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Align(
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Container(
              //                       padding: EdgeInsets.all(5),
              //                       margin: EdgeInsets.all(10),
              //                       decoration: BoxDecoration(
              //                         color: Colors.black.withOpacity(0.4),
              //                         borderRadius: BorderRadius.circular(15),
              //                       ),
              //                       child: Row(
              //                         children: [
              //                           SizedBox(width: 7),
              //                           Text(
              //                             articlestate.ingredient[index].amount.toString() + ' gram',
              //                             style: TextStyle(
              //                               color: Colors.white,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //                 alignment: Alignment.bottomLeft,
              //               ),
              //             ],
              //           ),
              //         );
              //       },
              //     ),
              //   ),
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
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      articlestate.ingredient[index].amount.toString() +
                                          ' gram',
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