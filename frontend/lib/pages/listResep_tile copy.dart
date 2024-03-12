import 'package:flutter/material.dart';

class ListResep extends StatelessWidget {
  final String recipe_img;
  final String recipe_name;
  final int number_ofCal;
  final String cooking_time;
  final double portion;
  final String difficulty;
  final int cooking_step;

  const ListResep(
      {super.key,
      required this.recipe_img,
      required this.recipe_name,
      required this.number_ofCal,
      required this.cooking_time,
      required this.portion,
      required this.difficulty,
      required this.cooking_step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
              height: 120,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // border: Border(
                //   top: BorderSide(
                //     color: Colors.black
                //   )
                // ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3.0, 3.0),
                      spreadRadius: 1.0,
                      blurRadius: 1),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48),
                          child: Image.network(
                            recipe_img,
                            height: 100,
                            width: 120,
                            fit: BoxFit.cover,),
                            // image: AssetImage(Tempe_Img),

                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          recipe_name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Calories
                            Row(
                              children: [
                                Icon(
                                  Icons.fastfood,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  number_ofCal.toString() + ' Kal',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                                // SvgPicture.asset("assets/calories-svgrepo-com.svg", width: 30,)
                              ],
                            ),

                            //cooking time
                            Row(
                              children: [
                                Icon(
                                  Icons.timelapse_outlined,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  cooking_time,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                                // SvgPicture.asset("assets/calories-svgrepo-com.svg", width: 30,)
                              ],
                            ),

                            //porsi
                            Row(
                              children: [
                                Icon(
                                  Icons.person_4_outlined,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  portion.toInt().toString() + ' Porsi',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                                // SvgPicture.asset("assets/calories-svgrepo-com.svg", width: 30,)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //dificulties & step
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xffB8E4B4).withOpacity(0.29),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  difficulty,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xffFF8B5E).withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  cooking_step.toString() + ' Langkah',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
