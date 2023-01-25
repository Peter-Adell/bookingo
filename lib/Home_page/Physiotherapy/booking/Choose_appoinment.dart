import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Home.dart';
import '../../chatbot/chatbot.dart';
import '../../menu/edit_profile.dart';
import 'confirming.dart';
import '../../../sharedPreferences/sharedPreferences.dart';

var docid;

class Choose_appoinmentPhysiotherapy extends StatefulWidget {
  final snapshot;

  const Choose_appoinmentPhysiotherapy({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<Choose_appoinmentPhysiotherapy> createState() => _Choose_appoinmentPhysiotherapyState();
}

class _Choose_appoinmentPhysiotherapyState extends State<Choose_appoinmentPhysiotherapy> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: _buildappbar(),
      ),
      body: _buildbody(snapshot: widget.snapshot),
      bottomNavigationBar: BottomNavigationBar(context),
    );
  }
}

class _buildbody extends StatefulWidget {
  final snapshot;

  const _buildbody({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<_buildbody> createState() => _buildbodyState();
}

class _buildbodyState extends State<_buildbody> {
  var lang = sharedPreferences.getUser('lang');

  double PlaceRate = 0.0;
  var appointment;
  var appointment_ar;
  var reservation_number;
  var isCheack = '';

  var list = [];
  var ckeckList = [];
  initState() {
    PlaceRate = double.parse(widget.snapshot['star_num']);
    _handelAppoint();
    _getData();
  }


  _getData() async{
    var uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('reservations')
        .where('doctor id' , isEqualTo:  widget.snapshot['id'])
        .where('status' , isEqualTo:  'active')
        .get().then((snap){
      for (var i in snap.docs){
        ckeckList.add(i['appointments']);
      }
    });
    print("ckeckList = $ckeckList");
  }

  _handelAppoint() {
    var x1 = widget.snapshot['Saturday'];
    var x2 = widget.snapshot['Sunday'];
    var x3 = widget.snapshot['Monday'];
    var x4 = widget.snapshot['Tuesday'];
    var x5 = widget.snapshot['Wednesday'];
    var x6 = widget.snapshot['Thursday'];

    var days = "${x1 == '-----------' ? '':('Saturday' + ', ' + x1 )}"+
        "${x2 == '-----------' ? '':('Sunday' + ', ' )}"+
        "${x3 == '-----------' ? '':('Monday' + ', ' )}" +
        "${x4 == '-----------' ? '':('Tuesday' + ', ' )}" +
        "${x5 == '-----------' ? '':('Wednesday' + ', ' )}" +
        "${x6 == '-----------' ? '':'Thursday'}" ;

    setState((){
      var li = [{"${x1 == '-----------' ? '' : ('Saturday' + ', ' + x1)}"},
        {"${x2 == '-----------' ? '' : ('Sunday' + ', ' + x2)}"},
        {"${x3 == '-----------' ? '' : ('Monday' + ', ' + x3)}"},
        {"${x4 == '-----------' ? '' : ('Tuesday' + ', ' + x4)}"},
        {"${x5 == '-----------' ? '' : ('Wednesday' + ', ' + x5)}"},
        {"${x6 == '-----------' ? '' : 'Thursday' + ', ' + x6}"
      }];
      for (var i in li){
        if(i.first != ''){
          list.add(i);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: ClipOval(
                      child: Image.network(
                        '${widget.snapshot['image_url']}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Text(
                lang == 'en'
                    ? "Dr: ${widget.snapshot['name']}"
                    : "د : ${widget.snapshot['name_ar']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: HexColor('#4E4E50'),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${lang == 'en' ? widget.snapshot['position'] : widget.snapshot['position_ar']}",
                style: TextStyle(
                  fontSize: 15,
                  color: HexColor('#4E4E50'),
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlaceRate == 0
                        ? Icon(Icons.star_outline, color: Colors.grey, size: 20)
                        : PlaceRate > 0 && PlaceRate < .5
                            ? Icon(Icons.star_half_sharp,
                                color: Colors.amber, size: 20)
                            : PlaceRate > .5
                                ? Icon(Icons.star_outlined,
                                    color: Colors.amber, size: 20)
                                : Container(),
                    PlaceRate <= 1
                        ? Icon(Icons.star_outline, color: Colors.grey, size: 20)
                        : PlaceRate > 1 && PlaceRate < 1.5
                            ? Icon(Icons.star_half_sharp,
                                color: Colors.amber, size: 20)
                            : PlaceRate > 1.5
                                ? Icon(Icons.star_outlined,
                                    color: Colors.amber, size: 20)
                                : Container(),
                    PlaceRate <= 2
                        ? Icon(Icons.star_outline, color: Colors.grey, size: 20)
                        : PlaceRate > 2 && PlaceRate < 2.5
                            ? Icon(Icons.star_half_sharp,
                                color: Colors.amber, size: 20)
                            : PlaceRate > 2.5
                                ? Icon(Icons.star_outlined,
                                    color: Colors.amber, size: 20)
                                : Container(),
                    PlaceRate <= 3
                        ? Icon(Icons.star_outline, color: Colors.grey, size: 20)
                        : PlaceRate > 3 && PlaceRate < 3.5
                            ? Icon(Icons.star_half_sharp,
                                color: Colors.amber, size: 20)
                            : PlaceRate > 3.5
                                ? Icon(Icons.star_outlined,
                                    color: Colors.amber, size: 20)
                                : Container(),
                    PlaceRate <= 4
                        ? Icon(Icons.star_outline, color: Colors.grey, size: 20)
                        : PlaceRate > 4 && PlaceRate < 4.5
                            ? Icon(Icons.star_half_sharp,
                                color: Colors.amber, size: 20)
                            : PlaceRate > 4.5
                                ? Icon(Icons.star_outlined,
                                    color: Colors.amber, size: 20)
                                : Container(),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text("$PlaceRate / 5",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                        Text("(${widget.snapshot['reviws_num']})",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.5))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return List(context, list[i], i);
                    }),
              ),
              SizedBox(height: 10),
              appointment == null
                  ? Container(
                      alignment: lang == 'en' ? Alignment.topLeft:Alignment.topRight,
                      child:
                          Text('$isCheack', style: TextStyle(color: Colors.red),
                          ),
                    )
                  : lang == 'en'
                      ? Row(
                          children: [
                            Text('Appointment Selected:\n       $appointment')
                          ],
                        )
                      : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'المعاد المختار:\n       $appointment_ar',
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
              SizedBox(height: 15),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor("#1C81AB"),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  width: 120,
                  height: 40,
                  child: TextButton(
                    onPressed: () async {
                      if (appointment != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Confirming(
                                      snapshot: widget.snapshot,
                                      appointment: appointment,
                                  appointment_ar: appointment_ar,
                                    )));
                      } else {
                        setState(() {
                          isCheack = lang == 'en' ? 'Please Select your Appointment':
                          'يرجى تحديد موعدك';
                        });
                      }
                    },
                    style: TextButton.styleFrom(primary: Colors.white),
                    child: Text(
                      lang == 'en' ? 'Next': 'التالى',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
    );
  }

  Widget List(context, snapshot, i) {
    var lang = sharedPreferences.getUser('lang');

    String x = snapshot.first;
    var y = x.split(',');
    var day = y.first;
    y.removeAt(0);

    var dayEN = day;

    if (day == 'Saturday' && lang == 'ar') {
      day = 'السبت';
    } else if (day == 'Sunday' && lang == 'ar') {
      day = 'الاحد';
    } else if (day == 'Monday' && lang == 'ar') {
      day = 'الاثنين';
    } else if (day == 'Tuesday' && lang == 'ar') {
      day = 'الثلاثاء';
    } else if (day == 'Wednesday' && lang == 'ar') {
      day = 'الاربعاء';
    } else if (day == 'Thursday' && lang == 'ar') {
      day = 'الخميس';
    } else if (day == 'Friday' && lang == 'ar') {
      day = 'الجمعه';
    }

    return Row(
      children: [
        Container(
            width: 120,
            height: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                        color: HexColor('#1C81AB'),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child:
                            Text('$day', style: TextStyle(color: Colors.white)))),
                Expanded(
                  child: Container(
                    height: 140,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: y.length,
                        itemBuilder: (context, i) {
                          return DateList(y[i], day, dayEN);
                        }),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  Widget DateList(date, day, dayEN){
    var x = date.split(' ');

    var start = "${x[1]}" +' '+ "${x[2]}";
    var end = "${x[4]}" +' '+ "${x[5]}";
    bool isRes = false;
    Color color = Colors.white;

    for(var i in ckeckList){

      if(i == "${dayEN + ' From' + ' ' + start + ' To ' + end}"){
          isRes = true;
          color = Colors.redAccent.withOpacity(0.1);
      }
    }
    
    return InkWell(
      onTap: (){
          if(!isRes){
            setState(() {
              appointment_ar = day + ' من ' + start + ' الى ' + end;
              appointment = dayEN + ' From' +' '+ start + ' To ' + end;
              isCheack = '';
              print("color = $color");
            });
          }else{
            setState(() {
              isCheack =  lang == 'en' ? 'This Appointment is Reserved' : 'هذا المعاد محجوز';
              appointment = null;
            });
          }

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:5,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
              color: color,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                  lang == 'en'
                      ? "From $start"
                      : "من $start",
                  textDirection:
                  lang == 'en' ? TextDirection.ltr : TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                  Text(
                    lang == 'en'
                        ? "To $end"
                        : "الى $end",
                    textDirection:
                    lang == 'en' ? TextDirection.ltr : TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: Colors.grey.withOpacity(.5),
            )
          ],
        ),
      ),
    );
  }
}

class _buildappbar extends StatelessWidget {
  var lang =sharedPreferences.getUser('lang');

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
          lang == 'en' ? "Choose your appointment" : "اختار الموعد",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
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
