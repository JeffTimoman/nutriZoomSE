import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsRec extends StatefulWidget {
  const DetailsRec({super.key});

  @override
  State<DetailsRec> createState() => _DetailsRecState();
}

class _DetailsRecState extends State<DetailsRec> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: 350,
              child: Image.network(
                'https://asset.kompas.com/crops/pG57GVX8vbZ8LKSnAiuWFh3gU6o=/89x0:934x563/750x500/data/photo/2020/11/12/5fac977441952.jpg',
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
                Text("Tempe Orek"),
                SizedBox(height: 10,),
                
                // Jumlah like
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite,
                    color: Colors.red,),
                    // Spacer(),
                    Text("120 Likes"),
                  ],
                ),
                
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
                              Text("20 menit")
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
                          // boxShadow: [
                          //   BoxShadow(
                          //     // blurRadius:,
                          //     color: Color(0xff3C6142).withOpacity(0.3),
                          //     offset: Offset(2, 3),
                          //     spreadRadius: 1
                          //   )
                          // ]
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.people_alt_rounded),
                              Text("4 porsi", style: TextStyle(color: Colors.black),)
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
                Text("Bahan"),
                SizedBox(height: 10,),
                layoutIngredients(context,
                  "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/jakartaakurat/2023/03/IMG_20230314_105758.jpg", 
                  "Tempe", "2 buah"),
                layoutIngredients(context,
                  "https://asset-2.tstatic.net/belitung/foto/bank/images/20220716-manfaat-bawang-putih-12.jpg", 
                  "Bawang Putih", "2 siung"),
                layoutIngredients(context,
                  "https://sesa.id/cdn/shop/products/bawang-merah-250g-1_460x@2x.jpg?v=1672116950", 
                  "Bawang Merah", "5 siung"),
                layoutIngredients(context,
                  "https://akcdn.detik.net.id/visual/2023/04/12/942985058_43.jpeg?w=720&q=90", 
                  "Kecap Manis", "5 sdm"),
                layoutIngredients(context,
                  "https://s1.bukalapak.com/attachment/668332/jenis-jenis_cabe_main_image.jpg", 
                  "Cabe Merah", "Secukupnya"),
              
                SizedBox(height: 10,),
                
                // Steps
                Text("Langkah Memasak"),
                layoutSteps(context, 0, 'Panaskan minyak, tumis bawang putih, lengkuas, dan daun salam hingga harum.'),
                layoutSteps(context, 1, 'Masukkan tempe, Royco Kaldu Ayam, Bango Kecap Manis Pedas, dan air. Aduk rata.'),
                layoutSteps(context, 2, 'Masak hingga bumbu meresap dan air mengering.'),
                layoutSteps(context, 3, 'Angkat dan sajikan.')
              ]),
            ),
          ),
        );
      }
    );
  }
  
  // Template Bahan
  layoutIngredients(BuildContext context, String urlImage, String namaBahan, String jumlahBahan) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(urlImage),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                  child: Text(namaBahan),
              ),
              Spacer(),
              Text(jumlahBahan)
            ],    
          ),
          Divider(
            height: 15,),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
  
  // Template Step
  layoutSteps(BuildContext context, int index, String step) {
    return Container(
      // width: 350,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xff3C6142),
            radius: 12,
            child: Text("${index + 1}", style: TextStyle(color: Colors.white, fontSize: 12),),
          ),
          SizedBox(width: 10,),
          Expanded(
            // height: 200,
            child: Text(
              step,
              softWrap: true,
              // overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
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
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
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
                      child: Image.asset('assets/image/popup_fav.png')),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        "Resep berhasil ditambahkan ke favorit!",
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      // padding: EdgeInsets.only(top: 20),
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xff3C6142).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () { 
                          Navigator.pop(context);
                        }, 
                        child: Text("Close",
                        style: TextStyle(
                          color: Colors.black
                        ),),

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
        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        color: isFavorite ? Colors.red : null,
        // Icons.favorite_outline_rounded
      ),

    );
  }
}


