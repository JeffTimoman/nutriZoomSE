import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/searchPages/textfield_search.dart';

class search_bahan extends StatefulWidget {
  search_bahan({super.key});
  static List previousSearchs = [];

  @override
  State<search_bahan> createState() => _search_bahanState();
}

class _search_bahanState extends State<search_bahan> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "Cari Bahan Makananmu",
                    // style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),

              // Search Bar
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CostomTextFormFild (
                          hint: "Cari Bahan", prefixIcon: Icons.search,
                          controller: searchController,
                          filled: true,
                          suffixIcon: 
                            searchController.text.isEmpty ? null : Icons.cancel_sharp,
                            onTapSuffixIcon: (){
                              searchController.clear();
                            },
                            onChanged: (pure){
                              setState(() {});
                            },
                            onEditingComplete: (){
                              search_bahan.previousSearchs.add(searchController.text);
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context)=> search_bahan())
                              );
                            },
                        )
                      ),
                    ],
                  ),
                ),
              ),

              // Precious Search
              Container(
                color: Colors.white,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: search_bahan.previousSearchs.length,
                  itemBuilder: (context, index) => previousSearchItems(index),
                ),
              ),

              // Search Suggestion
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sugesti Pencarian", style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(height: 20,),
                      Wrap(
                        
                        children: [
                          searchSuggestionItem("test test"),
                          searchSuggestionItem("test testttt"),
                          searchSuggestionItem("test"),
                          searchSuggestionItem("test"),
                          searchSuggestionItem("test"),
                          searchSuggestionItem("test"),
                        ],
                      )
                      ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  previousSearchItems(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: Color(0xFF9FA5C0),
            ),
            SizedBox(width: 10,),
            Text(
              search_bahan.previousSearchs[index]
            ),
            Spacer(),
            Icon(
              Icons.call_made_outlined,
              color: Color(0xFF9FA5C0),
            )
          ],
        ),
      ),
    );
  }
}

searchSuggestionItem(String suggestText){
  return Container(
    margin: EdgeInsets.only(right: 15, bottom: 15),
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(
        width: 1,
        color: Colors.black26
      ),
      borderRadius: BorderRadius.circular(30)),
    child: Text(
      suggestText,
      style: TextStyle(color: Color(0xff3C6142)),
    ),
  );
}
