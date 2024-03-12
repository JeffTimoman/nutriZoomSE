import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/bahan_search.dart';
import 'package:gabunginfrontend/pages/hasil_bahan/controller.dart';
// import 'package:gabunginfrontend/Alen/hasil_bahan/controller.dart';
import 'package:gabunginfrontend/pages/list_resep.dart';

class HasilBahan extends StatefulWidget {
  final String searchText;

  HasilBahan({Key? key, required this.searchText}) : super(key: key);

  @override
  State<HasilBahan> createState() => _HasilBahanState();
}

class _HasilBahanState extends State<HasilBahan> {
  late HasilBahanApi ingredientState = HasilBahanApi(
      id: 1, name: "", representation: "", description: "", nutrition: [], image: "https://www.astronauts.id/blog/wp-content/uploads/2022/11/Manfaat-Bawang-Putih-Untuk-Kulit-yang-Tidak-Banyak-Tahu-1024x683.jpg");
  final controller = Controller();
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            child: Image.network(
              ingredientState.image,
              // "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2023/05/26053515/Murah-dan-Bergizi-Ini-7-Manfaat-Tempe-yang-Masih-Jarang-Diketahui-.jpg.webp",
              fit: BoxFit.cover,
            ),
          ),
          buttonArrow(context),
          scrollBox()
        ],
      )),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scrollBox() {
    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black12,
                          ),
                          height: 5,
                          width: 35,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ingredientState.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    // indent: 10,
                    // endIndent: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ingredientState.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    "Ringkasan Nutrisi",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ingredientState.nutrition.map((data) {
                      return ringkasan(data);
                    }).toList(),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Divider(
                    color: Color(0xff3C6142),
                    height: 10,
                    thickness: 3,
                    // indent: 10,
                    // endIndent: 5,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Informasi Nilai Gizi",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Divider(
                    color: Color(0xff3C6142),
                    height: 10,
                    thickness: 3,
                    // indent: 10,
                    // endIndent: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Section 1
                  infoStandard(context, "Jumlah Sajian", "100"),
                  infoKalori(context, "192"),
                  Divider(
                    color: Color(0xff3C6142),
                    height: 10,
                    thickness: 2,
                    // indent: 10,
                    // endIndent: 5,
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ingredientState.nutrition.length,
                      itemBuilder: (context, index) {
                        Nutrition nutrition = ingredientState.nutrition[index];
                        return infoStandard(context, '${nutrition.name}',
                            '${nutrition.amount}');
                      }),

                  Divider(
                    color: Color(0xff3C6142),
                    height: 10,
                    thickness: 3,
                    // indent: 10,
                    // endIndent: 5,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.lightbulb_outlined,
                          color: Color(0xff3C6142),
                          size: 50,
                          shadows: [
                            Shadow(color: Colors.grey, offset: Offset(3.0, 3.0))
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "Bingung mau masak apa?",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Yuk, cek ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListResepPage(
                                                    judul_page: ingredientState.name,
                                                  )));
                                    },
                                    child: Text(
                                      "Resep " + ingredientState.name,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )),
                                // Text(
                                //   " disini!",
                                //   style: Theme.of(context).textTheme.bodyText1,
                                // ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  initState() {
    super.initState();
    getHasilBahan();
  }

  Future<void> getHasilBahan() async {
  final result = await Controller.fetchHasilNutrisiApi(widget.searchText);
  setState(() {
    ingredientState = result;
  });
  
  if (ingredientState.description == "") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => search_bahan(),
      ),
    );
  }
}

  Widget ringkasan(Nutrition nutrition) {
    if(nutrition.name == "Kalori" ||
        nutrition.name == "Protein" ||
        nutrition.name == "Lemak" ||
        nutrition.name == "Karbohidrat")
    {
      return Container(
          width: 60,
          height: 100,
          decoration: BoxDecoration(
      color: nutrition.name == 'Kalori' ? Color(0xff3C6142).withOpacity(0.3)
            : nutrition.name == "Protein" ?Color(0xffEEE966).withOpacity(0.25)
            : nutrition.name == "Lemak" ?Color(0xffFF8B5E).withOpacity(0.25)
            : nutrition.name == "Karbohidrat" ? Color(0xffC0B159).withOpacity(0.3)
            : Colors.white,
      borderRadius: BorderRadius.circular(30)),
          child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 7),
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Center(
              child: Text(
                "${nutrition.amount}",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Text(
            nutrition.name == "Karbohidrat" ? "Karbo"
              : "${nutrition.name}",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
          ),
        );
}
else{
  return SizedBox.shrink();
}
}
}

infoKalori(BuildContext context, String nilaiCal) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Kalori",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            nilaiCal + " Kalori",
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}

infoStandard(BuildContext context, String judul, String nilai) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            judul,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            nilai + " g",
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}

infoChild(BuildContext context, String child, String nilai) {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              child,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              nilai + " g",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
