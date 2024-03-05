import 'package:bagianjosh/pages/searchPages/bahan_search.dart';
import 'package:bagianjosh/pages/searchPages/nutrisi_search.dart';
import 'package:flutter/material.dart';

class TapBar extends StatefulWidget {
  TapBar({super.key});
  static List previousSearchs = [];

  @override
  State<TapBar> createState() => _TapBarState();
}

class _TapBarState extends State<TapBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3C6142),
        title: Text(
          "Pencarian",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        leading: Container(
          margin: EdgeInsets.all(18),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
            weight: 10,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            // height: 50,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Color(0xffB8E4B4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                    //   boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey.shade300,
                    //       offset: Offset(2.0, 2.0),
                    //       spreadRadius: 1.0,
                    //       blurRadius: 1
                    //       ),
                    // ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          child: TabBar(
                              labelColor: Color(0xff3C6142),
                              indicatorColor: Color(0xff3C6142),
                              unselectedLabelColor:
                                  Color(0xff195619).withOpacity(0.25),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 3,
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700),
                              controller: tabController,
                              tabs: [
                                Tab(
                                  text: "Bahan",
                                ),
                                Tab(
                                  text: "Nutrisi",
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  width: double.maxFinite,
                  height: 800,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      search_bahan(),
                      SearchNutrisi()
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
