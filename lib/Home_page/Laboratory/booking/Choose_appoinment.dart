import 'package:bookingo/Home_page/Laboratory/booking/confirming.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Home.dart';
import '../../chatbot/chatbot.dart';
import '../../menu/edit_profile.dart';
import 'package:bookingo/sharedPreferences/sharedPreferences.dart';

class Choose_appoinment extends StatefulWidget {
  final snapshot;
  final reserv_type;

  const Choose_appoinment({Key? key, required this.snapshot, required this.reserv_type}) : super(key: key);

  @override
  State<Choose_appoinment> createState() => _Choose_appoinmentState();
}

class _Choose_appoinmentState extends State<Choose_appoinment> {
  var lang = sharedPreferences.getUser('lang');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: _buildappbar(),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        height: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor('#1C81AB'), width: 2),
            borderRadius: BorderRadius.circular(45)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor('#1C81AB'), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${lang == 'en' ? widget.snapshot['title-en'] : widget.snapshot['title-ar']}',
                      style: TextStyle(fontSize: 17, color: HexColor('#4E4E50')),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                            height: 40,
                            width: 50,
                            child: Image(
                              image: AssetImage(widget.reserv_type == 'laboratory' ? 'assets/Laboratory_icon.png' : 'assets/scan_icon/X-rays.png'),
                            )),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset('assets/icons/time.png')),
                                SizedBox(width: 5),
                                Text(
                                  "${lang == 'en' ? "Waiting Time" : "وقت الانتظار"} :  ${widget.snapshot['wait_time']} ${lang == 'en' ? "Minutes" : "دقيقه"}",
                                  style: TextStyle(
                                      fontSize: 15, color: HexColor('#4E4E50')),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset('assets/icons/fee.png')),
                                SizedBox(width: 5),
                                Text(
                                  "${lang == 'en' ? "Price":"الرسوم"} :  ${widget.snapshot['fee']} ${lang == 'en' ? "EGB" : "جنيه مصرى"}",
                                  style: TextStyle(
                                      fontSize: 15, color: HexColor('#4E4E50')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                      snapshot: widget.snapshot,
                                      appointment: 'Saturday',
                                  appointment_ar: 'السبت',
                                    reserv_type: widget.reserv_type

                                )));
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Saturday' : 'السبت',
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                  snapshot: widget.snapshot,
                                  appointment: 'Sunday',
                                  appointment_ar: 'الاحد',
                                    reserv_type: widget.reserv_type
                                )));
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Sunday' : 'الاحد',
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                  snapshot: widget.snapshot,
                                  appointment: 'Monday',
                                  appointment_ar: 'الاثنين',
                                    reserv_type: widget.reserv_type

                                )));
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Monday' :"الاثنين",
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                  snapshot: widget.snapshot,
                                  appointment: 'Tuesday',
                                  appointment_ar: 'الثلاثاء',
                                    reserv_type: widget.reserv_type

                                )));
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Tuesday' :"الثلاثاء",
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                  snapshot: widget.snapshot,
                                  appointment: 'Wednesday',
                                  appointment_ar: 'الاربعاء',
                                    reserv_type: widget.reserv_type

                                )));
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Wednesday' : "الاربعاء",
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                  snapshot: widget.snapshot,
                                  appointment: 'Thursday',
                                  appointment_ar: 'الخميس',
                                    reserv_type: widget.reserv_type

                                )));
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Thursday' :"الخميس",
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(context),
    );
  }
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = sharedPreferences.getUser('lang');

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
          lang == 'en' ? "Choose your appointment" : "اختار الموعد",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Widget BottomNavigationBar(context) {
  return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/footer_2.png"), fit: BoxFit.cover),
      ),
      height: 70,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => chatbot()));
                },
                icon: Image.asset('assets/icons/chatbot.png')),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => Home_page()));
                },
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 40)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                       MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
