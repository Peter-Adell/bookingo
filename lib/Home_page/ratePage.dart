import 'package:bookingo/component/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../gsheets/sheets_api.dart';
import 'Home.dart';
import 'chatbot/chatbot.dart';
import 'menu/edit_profile.dart';
import '../../sharedPreferences/sharedPreferences.dart';

class RatePage extends StatefulWidget {
  final snapshot;

  const RatePage({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  var lang = sharedPreferences.getUser('lang');
  var revNum;
  var starNum;
  var img;

  bool starD1 = false;
  bool starD2 = false;
  bool starD3 = false;
  bool starD4 = false;
  bool starD5 = false;

  bool starA1 = false;
  bool starA2 = false;
  bool starA3 = false;
  bool starA4 = false;
  bool starA5 = false;

  bool starH1 = false;
  bool starH2 = false;
  bool starH3 = false;
  bool starH4 = false;
  bool starH5 = false;

  bool? isDataD;
  bool? isDataA;
  bool? isDataH;

  int starnumD = 0;
  int starnumA = 0;
  int starnumH = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDat();
  }

  _getDat() async {
    var x;
    if (widget.snapshot['specialization'] == 'Physiotherapy') {
      x = await SheetsApi.getPhysiotherapyById(
          int.parse(widget.snapshot['doctor id']));
    } else {
      x = await SheetsApi.getDoctorById(
          int.parse(widget.snapshot['doctor id']));
    }
    setState(() {
      revNum = x['reviws_num'];
      starNum = x['star_num'];
      img = x['image_url'];
      print("revNum = ${revNum}");
      print("starNum = ${starNum}");
    });
  }

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
          body:  Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(top: 5, left: 7, right: 7, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(
                          height: 30,
                        ),
                        widget.snapshot['reservation type'] =='clinics' ?
                        Container(
                          child: Column(
                            children: [
                              Text('Doctor',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#172B70'))),
                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starD1 = !starD1;
                                          starD2 = false;
                                          starD3 = false;
                                          starD4 = false;
                                          starD5 = false;
                                          starnumD = starD1 ? 1 : 0;
                                          isDataD = starD1;
                                        });
                                      },
                                      icon: starD1
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starD1 = true;
                                          starD2 = !starD2;
                                          starD3 = false;
                                          starD4 = false;
                                          starD5 = false;
                                          starnumD = starD2 ? 2 : 1;
                                          isDataD = true;
                                        });
                                      },
                                      icon: starD2
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starD1 = true;
                                          starD2 = true;
                                          starD3 = !starD3;
                                          starD4 = false;
                                          starD5 = false;
                                          starnumD = starD3 ? 3 : 2;
                                          isDataD = true;
                                        });
                                      },
                                      icon: starD3
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starD1 = true;
                                          starD2 = true;
                                          starD3 = true;
                                          starD4 = !starD4;
                                          starD5 = false;
                                          starnumD = starD4 ? 4 : 3;
                                          isDataD = true;
                                        });
                                      },
                                      icon: starD4
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starD1 = true;
                                          starD2 = true;
                                          starD3 = true;
                                          starD4 = true;
                                          starD5 = !starD5;
                                          starnumD = starD5 ? 5 : 4;
                                          isDataD = true;
                                        });
                                      },
                                      icon: starD5
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text('$starnumD / 5',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#172B70').withOpacity(0.5))),
                              ),
                            ],
                          ),
                        )
                        :Container(),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text('APP',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#172B70'))),
                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starA1 = !starA1;
                                          starA2 = false;
                                          starA3 = false;
                                          starA4 = false;
                                          starA5 = false;
                                          starnumA = starA1 ? 1 : 0;
                                          isDataA = starA1;
                                        });
                                      },
                                      icon: starA1
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starA1 = true;
                                          starA2 = !starA2;
                                          starA3 = false;
                                          starA4 = false;
                                          starA5 = false;
                                          starnumA = starA2 ? 2 : 1;
                                          isDataA = true;
                                        });
                                      },
                                      icon: starA2
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starA1 = true;
                                          starA2 = true;
                                          starA3 = !starA3;
                                          starA4 = false;
                                          starA5 = false;
                                          starnumA = starA3 ? 3 : 2;
                                          isDataA = true;
                                        });
                                      },
                                      icon: starA3
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starA1 = true;
                                          starA2 = true;
                                          starA3 = true;
                                          starA4 = !starA4;
                                          starA5 = false;
                                          starnumA = starA4 ? 4 : 3;
                                          isDataA = true;
                                        });
                                      },
                                      icon: starA4
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starA1 = true;
                                          starA2 = true;
                                          starA3 = true;
                                          starA4 = true;
                                          starA5 = !starA5;
                                          starnumA = starA5 ? 5 : 4;
                                          isDataA = true;
                                        });
                                      },
                                      icon: starA5
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text('$starnumA / 5',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#172B70').withOpacity(0.5))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text('Hospital service',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#172B70'))),
                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starH1 = !starH1;
                                          starH2 = false;
                                          starH3 = false;
                                          starH4 = false;
                                          starH5 = false;
                                          starnumH = starH1 ? 1 : 0;
                                          isDataH = starH1;
                                        });
                                      },
                                      icon: starH1
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starH1 = true;
                                          starH2 = !starH2;
                                          starH3 = false;
                                          starH4 = false;
                                          starH5 = false;
                                          starnumH = starH2 ? 2 : 1;
                                          isDataH = true;
                                        });
                                      },
                                      icon: starH2
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starH1 = true;
                                          starH2 = true;
                                          starH3 = !starH3;
                                          starH4 = false;
                                          starH5 = false;
                                          starnumH = starH3 ? 3 : 2;
                                          isDataH = true;
                                        });
                                      },
                                      icon: starH3
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starH1 = true;
                                          starH2 = true;
                                          starH3 = true;
                                          starH4 = !starH4;
                                          starH5 = false;
                                          starnumH = starH4 ? 4 : 3;
                                          isDataH = true;
                                        });
                                      },
                                      icon: starH4
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          starH1 = true;
                                          starH2 = true;
                                          starH3 = true;
                                          starH4 = true;
                                          starH5 = !starH5;
                                          starnumH = starH5 ? 5 : 4;
                                          isDataH = true;
                                        });
                                      },
                                      icon: starH5
                                          ? Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      )
                                          : Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text('$starnumH / 5',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#172B70').withOpacity(0.5))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        widget.snapshot['reservation type'] =='clinics' ?
                        (isDataD == true || isDataD == null) ||
                        (isDataA == true || isDataA == null) ||
                        (isDataH == true || isDataH == null)

                            ? SizedBox(height: 50)
                            : Container(
                                height: 50,
                                child: Text(
                                  'Please choose the rate',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ) :
                            (isDataA == true || isDataA == null) ||
                            (isDataH == true || isDataH == null)

                            ? SizedBox(height: 50)
                            : Container(
                          height: 50,
                          child: Text(
                            'Please choose the rate',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: HexColor("#1C81AB"),
                            borderRadius: BorderRadius.circular(21),
                          ),
                          width: 120,
                          height: 40,
                          child: TextButton(
                            onPressed: () async {
                              widget.snapshot['reservation type'] =='clinics' ?
                              _submitD() :
                              _submit();
                            },
                            style: TextButton.styleFrom(primary: Colors.white),
                            child: Text(
                              lang == 'en' ? 'Done' : 'تم',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textDirection: lang == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(context),
        ));
  }

  _submitD () async {
    if (isDataA == true || isDataH == true || isDataD == true) {
      showLoading(context);

      double x = double.parse(revNum) * double.parse(starNum);
      double y = x + starnumD;
      int NwRevieNum = int.parse(revNum) + 1;
      double NwStarNum = y / NwRevieNum;
      int id = int.parse(widget.snapshot['doctor id']);
      print("x = $x");
      print("y = $y");
      print("starnum = $starnumD");
      print("revNum = $revNum");
      print("starNum = $starNum");
      print("NwRevieNum = $NwRevieNum");
      print("NwStarNum = $NwStarNum");

      print("${double.parse(revNum) } ${ double.parse(starNum)}");
      if (widget.snapshot['specialization'] == 'Physiotherapy') {
        await SheetsApi.updatePhysiotherapyCell(
            id: id, Key: 'star_num', value: NwStarNum.toInt().toString());
        await SheetsApi.updatePhysiotherapyCell(
            id: id, Key: 'reviws_num', value: NwRevieNum.toInt().toString());
        await FirebaseFirestore.instance
            .collection('reservations')
            .doc(widget.snapshot['doc id'])
            .update({
          'rate': true,
        });
      }
      else {
        await SheetsApi.updateDoctorCell(
            id: id, Key: 'star_num', value: NwStarNum.toInt().toString());
        await SheetsApi.updateDoctorCell(
            id: id, Key: 'reviws_num', value: NwRevieNum.toInt().toString());
        await FirebaseFirestore.instance
            .collection('reservations')
            .doc(widget.snapshot['doc id'])
            .update({
          'rate': true,
        });
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Home_page()));
      final snackBar = SnackBar(
          content: Text(
            'Service Rated Succefully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightGreen);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        isDataD = false;
        isDataH = false;
        isDataA = false;
      });
    }
  }
  _submit() async {
    if(isDataA == true || isDataH == true){
      showLoading(context);

      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(widget.snapshot['doc id'])
          .update({
        'rate': true,
      });
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Home_page()));
      final snackBar = SnackBar(
          content: Text(
            'Service Rated Succefully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightGreen);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    else{
      setState(() {
        isDataH = false;
        isDataA = false;
      });
    }
  }
}

class _buildappbar extends StatelessWidget {
  var lang = sharedPreferences.getUser('lang');

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
          lang == 'en' ? "Rate Service" : "تقييم الخدمه",
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
