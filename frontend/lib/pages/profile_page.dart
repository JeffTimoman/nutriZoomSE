import 'package:bagianjosh/constants/img_strings.dart';
import 'package:flutter/material.dart';
// import 'package:gabunginfrontend/constant/img_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xff3C6142),
            //     Color.fromRGBO(255, 245, 212, 0.6),
            //     Color.fromRGBO(197, 211, 176, 0.6)
            //   ]),
            color: Color(0xff3C6142),
          ),

          //atas
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    color: Colors.white,
                    size: 27,
                  ),
                  Container(
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 27,
                    ),
                    margin: EdgeInsets.all(7.0),
                  ),
                ],
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "Akun",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    margin: EdgeInsets.only(top: 7.0, bottom: 30.0),
                  ),

                  CircleAvatar(
                    // margin: EdgeInsets.only(bottom: 30.0),
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage("https://i.pinimg.com/564x/35/04/d5/3504d58d12e46855f9bc0ff191331f8c.jpg"),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Clarensia Novia",
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.justify,
                  ),
                  // SizedBox(height: 5,),
                  Text(
                    "@bygum_masak",
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              // ListView(
              // children: <Widget>[
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: const Offset(5.0, 5.0),
                                blurRadius: 20,
                                spreadRadius: 1.0),
                            const BoxShadow(
                                color: Colors.black45,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5,
                                spreadRadius: 1.0)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                // SizedBox(height: 40,),
                                Container(
                                  child: Text(
                                    "Akun",
                                    style:
                                        Theme.of(context
                                        ).textTheme.headline2,
                                  ),
                                  padding: EdgeInsets.only(left: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AkunOption(context, "Ubah Profil"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                AkunOption(context, "Ubah Password"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                AkunOption(context, "Riwayat Resep"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                AkunOption(context, "Resep Favorit"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                AkunOption(context, "Ubah Nutrisi Harian"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Container(
                                  child: Text(
                                    "Tentang Aplikasi",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AkunOption(context, "Tentang"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AkunOption(context, "Pusat Bantuan"),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                SizedBox(
                                  height: 40,
                                ),

                                Container(
                                  height: 50,
                                  width: 150,
                                  padding: EdgeInsets.symmetric(horizontal: 100.0),
                                  // decoration: BoxDecoration(
                                  //     color: Color(0xff3C6142),
                                  //     borderRadius: BorderRadius.circular(100)),
                                  // child: TextButton(
                                  //   onPressed: () {},
                                  //   child: Text("KELUAR", style: Theme.of(context).textTheme.button,)),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "KELUAR",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff3C6142),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 80,),

                                Container(
                                  // width: 100,
                                  height: 100,
                                  child: Image(image: AssetImage(tLogo))),

                                SizedBox(height: 10,),

                                Text("v.10 beta", style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,),

                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ],
                      )))
              // ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector AkunOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
