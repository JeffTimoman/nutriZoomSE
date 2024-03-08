import 'dart:ui';
import 'package:bagianjosh/pages/list_resep.dart';
import 'package:flutter/material.dart';

class HasilBahan extends StatelessWidget {
  final String judul_bahan;
  const HasilBahan({super.key, required this.judul_bahan});

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
              "https://www.astronauts.id/blog/wp-content/uploads/2022/11/Manfaat-Bawang-Putih-Untuk-Kulit-yang-Tidak-Banyak-Tahu-1024x683.jpg",
                // "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2023/05/26053515/Murah-dan-Bergizi-Ini-7-Manfaat-Tempe-yang-Masih-Jarang-Diketahui-.jpg.webp",
                fit: BoxFit.cover,),
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
                    judul_bahan,
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
                    "Tempe merupakan makanan tradisional yang dihasilkan dari fermentasi biji kedelai atau beberapa bahan lainnya",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //CALORIES
                      Container(
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xff3C6142).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "280",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              Text(
                                "Kcal",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //PROTEIN
                      Container(
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffEEE966).withOpacity(0.25),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "280",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              Text(
                                "Protein",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //LEMAK
                      Container(
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffFF8B5E).withOpacity(0.25),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "280",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              Text(
                                "Lemak",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //KARBO
                      Container(
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffC0B159).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "280",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              Text(
                                "Karbo",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                  infoKalori(context, "193"),
                  Divider(
                    color: Color(0xff3C6142),
                    height: 10,
                    thickness: 2,
                    // indent: 10,
                    // endIndent: 5,
                  ),

                  //Section 2
                  SizedBox(
                    height: 10,
                  ),
                  infoStandard(context, "Total Lemak", "9.39"),
                  infoChild(context, "Lemak Jenuh", "2.3"),
                  infoStandard(context, "Kolestrol", "9.39"),
                  infoStandard(context, "Natrium", "9.39"),
                  infoStandard(context, "Kalium", "9.39"),
                  infoStandard(context, "Total Karbohidrat", "9.39"),
                  infoChild(context, "Serat Pangan", "2.3"),
                  infoChild(context, "Gula", "2.3"),
                  infoStandard(context, "Protein", "9.39"),

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
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListResepPage(judul_page: judul_bahan)));
                                  },
                                    child: Text(
                                  "Resep " + judul_bahan ,
                                  style: Theme.of(context).textTheme.headline4,
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
}
