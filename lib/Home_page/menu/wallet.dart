import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Home.dart';
import 'edit_profile.dart';
import '../../sharedPreferences/sharedPreferences.dart';


class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: _buildappbar(),
          ),
          body: SingleChildScrollView(
            child:
            _buildbody(),
          ),
          bottomNavigationBar: BottomNavigationBar(context),
        )
    );
  }
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 20),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        child: Container(alignment: Alignment.bottomCenter),
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
      ),
      title: Container(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          sharedPreferences.getUser('lang') == 'en' ? "Wallet" : "المحفظه",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _buildbody extends StatefulWidget {
  const _buildbody({Key? key}) : super(key: key);

  @override
  State<_buildbody> createState() => _buildbodyState();
}

class _buildbodyState extends State<_buildbody> {
  var activeBalance = double.parse(sharedPreferences.getUser('active balance')!);
  var pendingBalance = double.parse(sharedPreferences.getUser('pending balance')!);
  var lang = sharedPreferences.getUser('lang');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(

        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              border: Border.all(width: 1.5,color: Colors.grey.withOpacity(0.5),),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
              ],
              gradient: LinearGradient(
                colors: [HexColor('#F5F5F5'),HexColor('#DCDCDC')]
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,

                     children: [
                       Column(
                         children: [
                           Text(
                             "Booking go Cash",
                             style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                           ),
                           SizedBox(height: 10),
                           activeBalance > 0 ?
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 "${activeBalance}  ",
                                 style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.green),
                               ),
                               Text(
                                 "EGP",
                                 style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                               ),
                             ],
                           ): activeBalance < 0 ?
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,

                             children: [
                               Text(
                                 "${activeBalance}  ",
                                 style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.red),
                               ),
                               Text(
                                 "EGP",
                                 style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                               ),
                             ],
                           ):
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,

                             children: [
                               Text(
                                 "${activeBalance}  ",
                                 style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                               ),
                               Text(
                                 "EGP",
                                 style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                               ),
                             ],
                           ),
                         ],
                       )
                     ],
                   ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text(
                            "4695 2390 5167 1424",
                            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "27/04",
                            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(height: 5),
                          Text("${sharedPreferences.getUser('first_name')} ${sharedPreferences.getUser('last_name')}",
                            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.5)),

                          ),

                        ],
                      ),
                    )


                  ],
                )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.wifi),
                        SizedBox(width: 10),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/icons/sim.png',height: 40,width: 40,))
                      ],
                    )
                  ],
                )

              ],
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: Column(
              children: [
                lang == "en" ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your Active Cash:   ",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${activeBalance} EGP",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
                :Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "جنيه مصرى",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(width: 10),
                    Text(
                      " ${activeBalance}",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textDirection: TextDirection.ltr,

                    ),
                    SizedBox(width: 10),
                    Text(
                      "الرصيد المتاح : ",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),

                  ],
                ),
                SizedBox(height: 20),
                lang == "en" ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your Pending Cash:   ",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${pendingBalance} EGP",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
                :Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "جنيه مصرى",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(width: 10),
                    Text(
                      " ${pendingBalance}",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textDirection: TextDirection.ltr,

                    ),
                    SizedBox(width: 10),
                    Text(
                      "الرصيد المعلق : ",
                      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
Widget BottomNavigationBar(context) {
  return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/footer_2.png"),
          fit: BoxFit.cover,
        ),
      ),
      height: 70,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.message_outlined,
                    color: Colors.white, size: 40)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => Home_page()));
                },
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 40)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
