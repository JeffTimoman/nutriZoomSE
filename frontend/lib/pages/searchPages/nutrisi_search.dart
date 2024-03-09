// import 'dart:convert';
// import 'package:bagianjosh/pages/tapBar_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gabunginfrontend/pages/tapBar_search.dart';
// import 'package:gabunginfrontend/pages/tapBar_search.dart';
// import 'package:http/http.dart' as http;

class SearchNutrisi extends StatefulWidget {
  const SearchNutrisi({super.key});

  @override
  State<SearchNutrisi> createState() => _SearchNutrisiState();
}

class _SearchNutrisiState extends State<SearchNutrisi> {

  // GetNutrisi getNutrisi = null;
  Map<String, dynamic> data = {};
  int val = 1;

  // GetNutrisi.getNutrisi(page)

  // getData() async{
  //   final res = await http.get(Uri.parse("http://203.194.114.98/api/nutrition/get_nutrition?page=1"));
  //   if(res.statusCode == 200){
  //     setState(() {
  //       data = jsonDecode(res.body);
  //     });
  //   }
    
  //   // setState(() {
      
  //   // });
  // }

  var selectedItem = null;
  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
        body: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            "Mau penuhi nutrisi apa hari ini?",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        

        
        //Search Bar

        // DropdownButton(
        //   items: data.map((e) {
        //     return DropdownMenuItem(child: Text(e["nama"]), value:e["id"] ,);
        //   }).toList(), 
        //   value: val,
        //   onChanged: (v){
        //     val = v as int;
        //     setState(() {
        //       selectedItem = v.toString();
        //       TapBar.previousSearchs.add(selectedItem);
        //     });

        //   },),]

    

        DropdownSearch<String>(
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            showSearchBox: true,
          ),
          items: nutritions,
          dropdownButtonProps: DropdownButtonProps(color: Color(0xff3C6142)),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff3C6142)),
                borderRadius: BorderRadius.circular(10)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff3C6142)),
                borderRadius: BorderRadius.circular(10)
              ),
              prefixIcon: Icon(Icons.search),
              hintText: "Pilih nutrisimu!"
            ),
          ),
          onChanged: (value){
            // val = value as int;
            setState(() {
              selectedItem = value.toString();
              TapBar.previousSearchs.add(selectedItem);
            });
          },
          selectedItem: selectedItem,
          
        ),
        SizedBox(
          height: 20,
        ),

        //Previous Searches
        Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: TapBar.previousSearchs.length,
          itemBuilder: (context, index)=>previousSearchItem(index)),
        ),

        SizedBox(
          height: 20,
        ),

        //Search Suggestions
        Container(
          width: double.infinity,
          // padding: EdgeInsets.all(10),
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

        SizedBox(
          height: 20,
        ),

      ],
    ));
  }
}

String selectNutri = "";

final nutriSelected = TextEditingController();

//list of strings nutrisi (dropdown)

List<String> nutritions = [
  "Protein",
  "Serat",
  "Karbohidrat",
  "Lemak",
  "Vitamin C",
  "Zink",
  "Mineral"
];

previousSearchItem(int index){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    child: InkWell(
      onTap: () {},
      // child: Dismissible(
      //   key: GlobalKey(),
      //   onDismissed: (DismissDirection dir){
      //     setState()
      //     TapBar.previousSearchs.removeAt(index);
      //   },
        child: Row(
          children: [
            const Icon(Icons.history, color: Colors.grey,),
            const SizedBox(width: 10,),
            Text(TapBar.previousSearchs[index]),
            Spacer(),
            Icon(
              Icons.call_made_outlined,
              color: Colors.grey,
            )
          ],
        ),
      // ),
    ),
  );
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

