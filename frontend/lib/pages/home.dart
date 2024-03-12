import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:gabunginfrontend/pages/profile_page/controller.dart';
// import 'package:gabunginfrontend/Alen/profile_page/controller.dart';
// import 'package:gabunginfrontend/pages/Alen/profile_page.dart/controller.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  User? user;
  final controller = Controller();

  @override
  void initState() {
    super.initState();
    getUserData(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDE3MzQ3MCwianRpIjoiMGIwMDE1MzQtMzQ4Zi00M2NlLTk4NjgtYTE3OWI4NDBlY2Y1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MSwibmJmIjoxNzEwMTczNDcwLCJjc3JmIjoiNTVhYWU4NDUtOTg4Zi00NmNjLWFkNmUtZDFkODhlZjJmMjM0IiwiZXhwIjoxNzQxNzA5NDcwfQ.DIvB3DmFa0U-KiHqEXJf_b4Kr1M978YGPdFhg5t4Pwg");
  }

  Future<void> getUserData(String bearerToken) async {
    var result = await controller.getUserData(bearerToken);
    setState(() {
      user = result;
    });
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
            SingleChildScrollView(
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
                    Text(
                      "Kamu belum menambahkan resep favorit apapun!", 
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    // NANTI KASIH SI SLIDER ITU

                    SizedBox(height: 20,),
                    Text(
                      "Artikel Terkait",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
