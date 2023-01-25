import 'package:bookingo/Home_page/menu/edit_profile.dart';
import 'package:bookingo/Home_page/menu/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/loading.dart';
import '../../get_start/login.dart';
import '../../sharedPreferences/sharedPreferences.dart';
import '../Home.dart';
import 'aboutHospital.dart';
import 'bookings_history.dart';
import '../cart,checkout/cart_page.dart';
import 'contactUs.dart';




class user_menu extends StatefulWidget {
  const user_menu({Key? key}) : super(key: key);

  @override
  State<user_menu> createState() => _user_menuState();
}

class _user_menuState extends State<user_menu> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
var lang = sharedPreferences.getUser('lang');


  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          sharedPreferences.getUser('imgUrl') != null ? Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45.0,
                    child: ClipOval(
                      child: Image.network(
                        "${sharedPreferences.getUser('imgUrl')}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${sharedPreferences.getUser('first_name')} ${sharedPreferences.getUser('last_name')}"),
                      Text("${sharedPreferences.getUser('email')}")],
                  ),
                ),

              ],
            ),
          ): CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (builder) => edit_profile(),
                  ));
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.perm_identity_rounded,
                        color: HexColor("#374151")),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(lang == 'en' ?
                    "Account setting":"اعدادات الحساب",
                        style: TextStyle(
                          color: HexColor('##374151'),
                          fontSize: 16,
                        )),
                  ),
                  Expanded(
                    child:
                    Icon(Icons.settings, size: 20, color: HexColor("#374151")),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Icon(Icons.translate,
                      color: HexColor("#374151")),
                ),
                
                Expanded(
                  flex: 3,
                  child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: InkWell(
                                onTap: () async {
                                  showLoading(context);
                                  var lang = await sharedPreferences.getUser('lang');
                                  if(lang == 'ar'){
                                    await FirebaseFirestore.instance.collection('users').doc(uid).update(
                                        {
                                          'lang':'en',
                                        });
                                    await sharedPreferences.setUser('lang', 'en');
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) => Home_page(),
                                        ));
                                  }
                                },
                                child: Text('English',
                                style: TextStyle(color: lang == 'en' ? HexColor("#1C81AB") : Colors.black),),
                              )
                              ),

                          Expanded(child: InkWell(
                            onTap: () async {
                              showLoading(context);
                              var lang = await sharedPreferences.getUser('lang');
                              if(lang == 'en'){
                                await FirebaseFirestore.instance.collection('users').doc(uid).update(
                                    {
                                      'lang':'ar',
                                    });
                                await sharedPreferences.setUser('lang', 'ar');
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => Home_page(),
                                    ));
                              }
                            },
                            child: Text('العربيه',
                              style: TextStyle(color: lang == 'ar' ? HexColor("#1C81AB") : Colors.black),),
                          )
                          ),

                        ],
                      )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => Home_page(),
                          ));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child:
                          Icon(Icons.home_outlined, color: HexColor("#374151")),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(lang == 'en' ?
                          "Home":"الصفحه الرئيسيه",
                              style: TextStyle(
                                color: HexColor('#374151'),
                                fontSize: 16,
                              )),
                        ),
                        Expanded(
                          child: Icon(Icons.arrow_forward_ios_sharp,
                              size: 15, color: HexColor("#9CA3AF")),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => Wallet(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(Icons.account_balance_wallet_outlined,
                            color: HexColor("#374151")),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(lang == 'en' ?
                        "Wallet":"المحفظه",
                            style: TextStyle(
                              color: HexColor('##374151'),
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_forward_ios_sharp,
                            size: 15, color: HexColor("#9CA3AF")),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => cart(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child:
                        Image.asset('assets/icons/checkout.png',height: 35,width:35,),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(lang == 'en' ?
                        "checkout":"الدفع",
                            style: TextStyle(
                              color: HexColor('#374151'),
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_forward_ios_sharp,
                            size: 15, color: HexColor("#9CA3AF")),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => bookings_history(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(Icons.history,
                            color: HexColor("#374151")),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(lang == 'en' ?
                        "Booking history":"سجل الحجز",
                            style: TextStyle(
                              color: HexColor('##374151'),
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_forward_ios_sharp,
                            size: 15, color: HexColor("#9CA3AF")),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => ContactUs(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child:
                        Icon(Icons.contact_phone_outlined, color: HexColor("#374151")),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(lang == 'en' ?
                        "Contact US":"اتصل بنا",
                            style: TextStyle(
                              color: HexColor('##374151'),
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_forward_ios_sharp,
                            size: 15, color: HexColor("#9CA3AF")),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => AboutHospital(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                  child: Icon(Icons.feedback_outlined,
                      color: HexColor("#374151")),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(lang == 'en' ?
                        "About hospital":"عن المستشفى",
                            style: TextStyle(
                              color: HexColor('##374151'),
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_forward_ios_sharp,
                            size: 15, color: HexColor("#9CA3AF")),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    var url = Uri.parse('https://drive.google.com/drive/folders/1RBsoJG2ih-6PF7pX9bTkkF8oa1SZyn45?usp=sharing');
                    if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(Icons.info_outlined,
                            color: HexColor("#374151")),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(lang == 'en' ?
                        "App instructions":"تعليمات التطبيق",
                            style: TextStyle(
                              color: HexColor('##374151'),
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_forward_ios_sharp,
                            size: 15, color: HexColor("#9CA3AF")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: HexColor("#BC2C2C"),
              borderRadius: BorderRadius.circular(15),
            ),
            width: lang == 'en' ? 90:120,
            height: 35,
            child: new TextButton(
                style: TextButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  await  sharedPreferences.clear();
                  instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
                child: Center(
                  child: Text(
                    lang == 'en' ?
                    "Logout":"تسجيل الخروج",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ]),
      ),
    );
  }

}
