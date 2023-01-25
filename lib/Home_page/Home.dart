
import 'package:bookingo/Home_page/scan_center/home.dart';
import 'package:bookingo/Home_page/menu/user_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as dddd;

import '../component/loading.dart';
import '../sharedPreferences/sharedPreferences.dart';
import 'Laboratory/home.dart';
import 'Physiotherapy/PhysiotherapyDoctorsList.dart';
import 'chatbot/chatbot.dart';
import 'clinics/home.dart';
import 'menu/edit_profile.dart';
import 'menu/notificationPage.dart';





class Home_page extends StatefulWidget {

  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
        icon: Icon(
          Icons.menu,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () => Scaffold.of(
          context,
        ).openDrawer(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 10,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(29.0),
                bottomRight: Radius.circular(29.0))),
      ),
      title: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            "Booking Go",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 15.0),
          child: IconButton(
            icon:Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
            size: 30,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>NotiFicationPage()));

            },
          ),
        ),
      ],
    );
  }
}

class _Home_pageState extends State<Home_page> {
  var reserv_num;

  bool reserv = false;


@override
  void initState() {

  _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset: false,
        drawer: user_menu(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _buildappbar(),
      ),
      body: _builidbody(reservation: reserv),
      bottomSheet: reserv
          ? Container(
              width: double.infinity,
              height: 0,
              alignment: Alignment.topCenter,
            )
          : Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.topCenter,
              child: Text(
                sharedPreferences.getUser('lang') == "en" ? 'Select service category':'اختر الخدمه المطلوبه ',
                style: TextStyle(
                    fontSize: 25,
                    color: HexColor('#4E4E50'),
                    fontWeight: FontWeight.bold),
              )),
      bottomNavigationBar: BottomNavigationBar(context),
    );
  }
  _getdata() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences.setUser('first_name', snapshot.data.call()!['first name']);
      await sharedPreferences.setUser('last_name', snapshot.data.call()!['last name']);
      await sharedPreferences.setUser('phone', snapshot.data.call()!['phone']);
      await sharedPreferences.setUser('city', snapshot.data.call()!['city']);
      await sharedPreferences.setUser('imgUrl', snapshot.data.call()!['image url']);
      await sharedPreferences.setUser('email', snapshot.data.call()!['email']);
      await sharedPreferences.setUser('gender', snapshot.data.call()!['gender']);
      await sharedPreferences.setUser('active balance', snapshot.data.call()!['active balance'].toString());
      await sharedPreferences.setUser('pending balance', snapshot.data.call()!['pending balance'].toString());
      await sharedPreferences.setUser('userid', snapshot.data.call()!['userid']);
      await sharedPreferences.setUser('lang', snapshot.data.call()!['lang']);
    });

    await FirebaseFirestore.instance
        .collection('reservations')
        .where('user id', isEqualTo: uid)
        .where('status', isEqualTo: 'active')
        .get()
        .then((snapshot) {
      setState(() {
        reserv_num = snapshot.size;
      });
      if(reserv_num>0){
        setState(() {
          reserv = true;
        });
      }
    });


  }

}

class _builidbody extends StatelessWidget {
  final reservation;

   _builidbody({Key? key, this.reservation}) : super(key: key);

  var uid = FirebaseAuth.instance.currentUser!.uid;
var ref = FirebaseFirestore.instance.collection('reservations');

  @override
  Widget build(BuildContext context) {
    return reservation
        ? Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: FutureBuilder(
                        future: ref.where('status', isEqualTo: 'active')
                            .where('user id', isEqualTo: uid).get(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, i) {
                                  return reserv_list(snap: snapshot.data.docs[i],docid: snapshot.data.docs[i].id);
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        })),
                Expanded(
                    flex: sharedPreferences.getUser('lang') == 'en' ?  5: 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>clinic_home()));
                                  },
                                  child: _section("Clinics","العيادات", "assets/clinic.png",
                                      reservation),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>Laboratory_home()));
                                  },
                                child: _section("Laboratories", "المعَامل", "assets/Laboratory.png", reservation),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>scanCenter_home()));
                                  },
                                  child: _section("Scan center",
                                      "مركز الاشعه","assets/scan.png", reservation),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) => PhysiotherapyDotcorList(),
                                        ));
                                  },
                                  child: _section("physiotherapy sessions",
                                      "العلاج الطبيعى", "assets/physiotherapy.png", reservation),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )
        : Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Flexible(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => clinic_home(),
                                  ));
                            },
                            child: _section(
                                "Clinics","العيادات", "assets/clinic.png", reservation)),
                        flex: 1,
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => Laboratory_home(),
                                ));
                          },
                          child: _section("Laboratories","المعَامل",
                              "assets/Laboratory.png", reservation),
                        ),
                        flex: 1,
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => scanCenter_home(),
                                ));
                          },
                          child: _section(
                              "Scan center", "مركز الاشعه", "assets/scan.png", reservation),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => PhysiotherapyDotcorList(),
                                  ));
                            },
                            child: _section("physiotherapy sessions", "العلاج الطبيعى",
                                "assets/physiotherapy.png", reservation)),
                        flex: 1,
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          );
  }
}


class reserv_list extends StatefulWidget {
  final docid;
  final snap;
  const reserv_list({Key? key, required this.snap, required this.docid}) : super(key: key);

  @override
  State<reserv_list> createState() => _reserv_listState();
}

class _reserv_listState extends State<reserv_list> {
  var lang = sharedPreferences.getUser('lang');
  @override
  Widget build(BuildContext context) {
    return widget.snap['reservation type'] == 'clinics'
        ? Container(
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 40, top: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${lang == 'en' ? 'Patient name':'اسم المريض'} : ${widget.snap['patient name']}",
                        textDirection: TextDirection.rtl,
                        maxLines: 1,

                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                              .withOpacity(.5),
                        ),
                      ),
                      Text(
                        lang == 'en' ? "specialization: ${widget.snap['specialization']}" : "التخصص: ${widget.snap['specialization ar']}",
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,

                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                                .withOpacity(.5)),
                      ),
                      Text(
                        "${lang == 'en' ? "reservation type : clinics":'نوع الحجز: العيادات'}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                        maxLines: 1,
                      ),
                      Text(
                        "${lang == "en" ? "Clinic number" : "رقم العياده"}  : ${widget.snap['clinic num']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                                .withOpacity(.5)),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          InkWell(
                              onTap:(){
                                _delete_alert(context, widget.snap,widget.docid);
                              },
                              child: Image.asset('assets/icons/cancel.png')),
                          SizedBox(width: 5),
                          InkWell(
                              onTap:(){
                                _report_alert(context, widget.docid);
                              },
                              child: Image.asset('assets/icons/help.png')),
                          SizedBox(width: 5),

                          InkWell(
                              onTap: (){
                                _ClinicLocation_alert(context);
                              },
                              child: Image.asset('assets/icons/30.png')),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: (){
                              _HospitalLocation_alert(context);
                            },
                            child: Image.asset(
                                'assets/icons/location.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.topRight,
                        child: QrImage(
                          data: widget.snap['secKey'].toString(),
                          size: 200,
                        ),
                      ),
                      SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                          Text('0',style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    )
        : widget.snap['reservation type'] == 'laboratory'
        ? Container(
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 40, top: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${lang == 'en' ? 'Patient name':'اسم المريض'} : ${widget.snap['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                        maxLines: 1,
                      ),
                      Text(
                        "${lang == 'en' ? "reservation type : Laboratory":'نوع الحجز: المعمل'}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == 'en' ? "Test Name : ${widget.snap['test name-en']}":'اسم التحليل  : ${widget.snap['test name-ar']}'}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                                .withOpacity(.5)),
                        maxLines: 1,
                      ),
                      Text(
                        lang == 'en' ? "appointments : ${widget.snap['appointments']}" : "الموعد : ${widget.snap['appointments ar']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                              onTap:(){
                                _delete_alert(context, widget.snap, widget.docid);
                              },
                              child: Image.asset('assets/icons/cancel.png')),
                          SizedBox(width: 5),
                          InkWell(
                              onTap:(){
                                _report_alert(context, widget.docid);
                              },
                              child: Image.asset('assets/icons/help.png')),
                          SizedBox(width: 5),
                          InkWell(
                              onTap: (){
                                _ClinicLocation_alert(context);
                              },
                              child: Image.asset('assets/icons/30.png')),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: (){
                              _HospitalLocation_alert(context);
                            },
                            child: Image.asset(
                                'assets/icons/location.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 70,
                          width: 70,
                          alignment: Alignment.topRight,
                          child: QrImage(
                            data: widget.snap['secKey'].toString(),
                            size: 200,
                          ),
                      ),
                      SizedBox(height: 5),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                          Text('0',style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    )
        : widget.snap['reservation type'] == 'scan'
        ? Container(
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 40, top: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${lang == 'en' ? 'Patient name':'اسم المريض'} : ${widget.snap['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                        maxLines: 1,
                      ),
                      Text(
                        "${lang == 'en' ? "reservation type : Scan Center":'نوع الحجز: مركز الاشعه'}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                        maxLines: 1,
                      ),
                      Container(

                        child: Text(
                          "${lang == 'en' ? "Scan Name : ${widget.snap['scan name-en']}":'اسم الاشعه  : ${widget.snap['scan name-ar']}'}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                                  .withOpacity(.5)),
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        lang == 'en' ? "appointments : ${widget.snap['appointments']}" : "الموعد : ${widget.snap['appointments ar']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                              onTap:(){
                                _delete_alert(context, widget.snap, widget.docid);
                              },
                              child: Image.asset('assets/icons/cancel.png')),
                          SizedBox(width: 5),
                          InkWell(
                              onTap:(){
                                _report_alert(context, widget.docid);
                              },
                              child: Image.asset('assets/icons/help.png')),
                          SizedBox(width: 5),
                          InkWell(
                              onTap: (){
                                _ClinicLocation_alert(context);
                              },
                              child: Image.asset('assets/icons/30.png')),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: (){
                              _HospitalLocation_alert(context);
                            },
                            child: Image.asset(
                                'assets/icons/location.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.topRight,
                        child: QrImage(
                          data: widget.snap['secKey'].toString(),
                          size: 200,
                        ),
                      ),
                      SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                          Text('0',style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    )
        : Container();
  }

  _delete_alert(context, snap,docid) {
    var lang =sharedPreferences.getUser('lang');

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(lang == 'en' ? "Cancel Reservation" : "الغاء الحجز",
              textDirection: lang == 'en' ? TextDirection.ltr :TextDirection.rtl,
            ),
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(lang == 'en' ? "Are you sure you want to cancel this reservation?\nYou may be charged for doing that!"
                        : "هل تريد بالتأكيد إلغاء هذا الحجز؟ \n قد يتم تحصيل رسوم منك مقابل القيام بذلك!",
                      textDirection: lang == 'en' ? TextDirection.ltr :TextDirection.rtl,
                      style: TextStyle(
                          color: HexColor('#172B70'),
                          fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _delete(context, snap, docid);
                          },
                          child: Container(
                            width: 70,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: HexColor("#E43B3B"),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(child: Text(lang == 'en' ? 'Yes' : "الغاء",
                                style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 70,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: HexColor("#2CBD35"),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(child: Text(lang == 'en' ? 'No' : "رجوع",
                              style: TextStyle(color: Colors.white),)),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _delete(context, snap, docid)async{
    try{
      showLoading(context);
      var k = double.parse(snap['fees']);
      var tax =  k * 0.1;

      if(snap['reservation type'] == 'clinics'){

        var appointments = snap['appointments'];
        var D = appointments.split(' ');
        var reserDay = D[0];

        var reserhour = D[2]+' '+"${D[3] == 'pm' ? 'PM': 'AM'}";
        var  z = reserhour.split(' ');
        var x = z[0].split(':');
        var reserHour = int.parse(z[1] == 'PM' ? "${int.parse(x[0])+12}" : "${x[0]}");

        var day = snap['day'];
        var hour = snap['hour'];
        var Hour = int.parse(hour);

        var dayNW = dddd.DateFormat('EEEE').format(DateTime.now());
        var hourNW = dddd.DateFormat('HH').format(DateTime.now());
        var HourNW = int.parse(hourNW);


        if(day == reserDay && dayNW == reserDay){
          if(reserHour - Hour <= 6 ){
            if(reserHour - HourNW <= 1){
              await canceleWithTax(context, docid, tax);
            }
            else if(reserHour - Hour > 1){
              await canceleWithOut(context, docid);
            }
          }
          else if(reserHour - Hour > 6){
            if(reserHour - HourNW <= 6){
              await canceleWithTax(context, docid, tax);
            }else if(reserHour - HourNW > 6){
              await canceleWithOut(context, docid);
            }
          }
        }
        else if(day != reserDay && dayNW == reserDay){
          if(reserHour - HourNW <= 6 ){
            print('<=====canceleWithTax=====');
            await canceleWithTax(context, docid, tax);
          }
          else if(reserHour - HourNW > 6){
            print('>=====canceleWithOut=====');
            await canceleWithOut(context, docid);
          }
        }
        else {
          await canceleWithOut(context, docid);
        }

      }
      else if(snap['reservation type'] != 'clinics'){

        var dayNW = dddd.DateFormat('EEEE').format(DateTime.now());
        var reserDay = snap['appointments'];


        if(dayNW == reserDay){
          await canceleWithTax(context, docid, tax);
        }else{
          await canceleWithOut(context, docid);
        }
      }
    }
    catch(e){}
  }
}

canceleWithTax(context, docid,double tax) async {
  var activeBalance = double.parse(sharedPreferences.getUser('active balance')!);

  var uid = await FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection('reservations')
      .doc(docid).update({
    "status" : "canceled",
  });
  await FirebaseFirestore.instance.collection('users')
      .doc(uid).update({
    "active balance" : activeBalance - tax,
  });
  final snackBar = SnackBar(content: Text('Reservations Deleted successfully , Taxes Charged :$tax EGP',style: TextStyle(color: Colors.white),),backgroundColor: Colors.red);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Home_page()));
}

canceleWithOut(context, docid, ) async {
  await FirebaseFirestore.instance.collection('reservations')
      .doc(docid).update({
    "status" : "canceled",
  });
  final snackBar = SnackBar(content: Text('Reservations Deleted successfully with zero Taxes Charged',style: TextStyle(color: Colors.white),),backgroundColor: Colors.lightGreen);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Home_page()));
}

Widget _section(String name, String name_ar, String img, reservation) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Center(
      child: reservation
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    sharedPreferences.getUser('lang') == "en" ? '$name':'$name_ar',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: HexColor("#4E4E50"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: AssetImage(
                          '$img',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    sharedPreferences.getUser('lang') == "en" ? '$name':'$name_ar',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: HexColor("#4E4E50"),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: AssetImage(
                          '$img',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ),
  );
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


_report_alert(context, docid) {
  var lang =sharedPreferences.getUser('lang');

  var message;
  final _formkey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
              title: Center(child: Text(lang == 'en' ? "Report" : "ابلاغ",style: TextStyle(
                  color: Colors.red,
                  fontSize: 18
              ),)),
              content: Container(
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(lang == 'en' ? "If find any problem with booking or have a suggestion write it here.." :
                      "إذا وجدت أي مشكلة في الحجز أو لديك اقتراح ، فاكتبها هنا ..",
                        textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style: TextStyle(
                            color: HexColor('#172B70'),
                            fontSize: 18
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                            textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,

                            maxLines: 10,
                            maxLength: 500,
                            initialValue: '',
                            decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.all(15),

                          hintText: lang == 'en' ? 'type thing ...' : "... اكتب شئ",
                          hintStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color:
                              HexColor("#205072").withOpacity(0.5)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: HexColor('#B3C3FF'),
                            ),
                          ),
                        ),
                            onChanged: (text) {
                              message = text;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return lang == 'en' ? 'Please Enter Your Message' : "من فضلك ادخل رسالتك هنا";
                              }
                            }),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        width: 120,
                        height: 40,
                        child: TextButton(
                          onPressed: () async {
                            if(_formkey.currentState!.validate()){
                              Navigator.pop(context);
                            }
                          },
                          style:
                          TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                              lang == 'en' ? 'Send' : "ارسال",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            scrollable: true,


        );
      });
}

_ClinicLocation_alert(context) {
  var lang =sharedPreferences.getUser('lang');
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Center(child: Text(lang == 'en' ? "Clinic location" : "موقع العياده",style: TextStyle(
              color: Colors.red,
              fontSize: 18
          ),)),
          content: Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/clinic_location.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 120,
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      style:
                      TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ?'Ok':'تم',
                        textDirection:  lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


        );
      });
}

_HospitalLocation_alert(context) {
  var lang =sharedPreferences.getUser('lang');

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Center(child: Text(lang == 'en' ? "Hospital Location " : "موقع المستشفى",style: TextStyle(
              color: Colors.red,
              fontSize: 18
          ),)),
          content: Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/hospital_location.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 120,
                    height: 45,
                    child: TextButton(
                      onPressed: () async {
                        const String link = 'https://www.google.com/maps/place/43-427+Shaarawy,+San+Stefano,+El+Raml+2,+Alexandria+Governorate+5452056/@31.2504475,29.9705113,18z/data=!4m2!3m1!1s0x14f5c5338ee13105:0x24eb6a9651a0199d';
                        Navigator.pop(context);
                        if (await canLaunch(link)) {
                          await launch(link);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      style:
                      TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Go' : 'اذهب',
                        textDirection:  lang == 'en' ? TextDirection.ltr:TextDirection.rtl,

                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


        );
      });
}


