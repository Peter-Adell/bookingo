import 'dart:convert';

import 'package:bookingo/sharedPreferences/sharedPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home.dart';
import '../../cart,checkout/checkout.dart';
import '../../chatbot/chatbot.dart';
import '../../menu/edit_profile.dart';

class Confirming extends StatefulWidget {
  final snapshot;
  final appointment;
  final appointment_ar;
  final reserv_type;

  const Confirming(
      {Key? key, required this.appointment, required this.snapshot, required this.appointment_ar, required this.reserv_type})
      : super(key: key);

  @override
  State<Confirming> createState() => _ConfirmingState();
}

class _ConfirmingState extends State<Confirming> {
  @override
  void initState() {
    // TODO: implement initState
    final prefs = SharedPreferences.getInstance();
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
        body: SingleChildScrollView(
            child: _buildbody(
                snapshot: widget.snapshot, appointment: widget.appointment, appointment_ar: widget.appointment_ar ,reserv_type: widget.reserv_type,)),
        bottomNavigationBar: BottomNavigationBar(context),
      ),
    );
  }
}

class _buildbody extends StatefulWidget {
  final snapshot;
  final appointment;
  final appointment_ar;
  final reserv_type;

  const _buildbody({
    Key? key,
    required this.snapshot,
    required this.appointment,
    required this.appointment_ar,
    required this.reserv_type
  }) : super(key: key);

  @override
  State<_buildbody> createState() => _buildbodyState();
}

class _buildbodyState extends State<_buildbody> {
  var lang = sharedPreferences.getUser('lang');

  bool isChecked = false;

  final _formkey = GlobalKey<FormState>();

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller.text = "${sharedPreferences.getUser('first_name')} ${sharedPreferences.getUser('last_name')}";
    _phonecontroller.text = "${sharedPreferences.getUser('phone')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(top: 5, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: HexColor("#1C81AB"),
        ),
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
      child: Column(
        children: [
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
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: 220
                              ),
                              child: Text(
                                "${lang == 'en' ? "Waiting Time" : "وقت الانتظار"} :  ${widget.snapshot['wait_time']} ${lang == 'en' ? "Minutes" : "دقيقه"}",
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#4E4E50')),
                              ),
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
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black.withOpacity(.6),
                  size: 45,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: 1,
                  height: 130,
                  color: Colors.black.withOpacity(.7),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                                if(isChecked){
                                  _phonecontroller.clear();
                                  _namecontroller.clear();
                                }else if(!isChecked){
                                  setState(() {
                                    _namecontroller.text = "${sharedPreferences.getUser('first_name')} ${sharedPreferences.getUser('last_name')}";
                                    _phonecontroller.text = "${sharedPreferences.getUser('phone')}";
                                  });
                                }
                              },
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: 200
                              ),
                              child: Text(
                                lang == 'en' ?
                                'I am booking for another patient' :
                                'أنا أحجز لمريض آخر',                              style: TextStyle(
                                    fontSize: 16, color: HexColor('#4E4E50')),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 30, bottom: 10),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 55,
                                child: TextFormField(
                                  enabled: isChecked,
                                  controller: _namecontroller,
                                  cursorColor: Colors.black.withOpacity(.4),
                                  style: TextStyle(
                                      color: HexColor('#24688F'), fontSize: 16),
                                  decoration: InputDecoration(
                                    label: isChecked ? Text(lang == 'en' ? 'Patient name' : 'اسم المريض') : null,
                                    labelStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                    hintText: lang == 'en' ? 'Enter Patient Name' : 'ادخل اسم المريض',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor('#1C81AB'))),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return lang == 'en' ? 'Please Enter Patient Name' : 'الرجاء إدخال اسم المريض';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                height: 55,
                                child: TextFormField(
                                  enabled: isChecked,
                                  keyboardType: TextInputType.phone,
                                  controller: _phonecontroller,
                                  cursorColor: Colors.black.withOpacity(.4),
                                  style: TextStyle(
                                      color: HexColor('#24688F'), fontSize: 16),
                                  decoration: InputDecoration(
                                    label: isChecked ? Text(lang == 'en' ? 'Patient phone':'رقم المريض') :null,
                                    labelStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                    hintText: lang == 'en' ? 'Enter Patient phone number' : 'أدخل رقم هاتف المريض',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor('#1C81AB'))),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return lang == 'en' ? 'Please Enter Patient phone number' : 'الرجاء إدخال رقم هاتف المريض';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment:lang == 'en' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      Text(lang == 'en' ? 'Appointment' : 'الموعد'),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          lang == 'en' ? '${widget.appointment}' : '${widget.appointment_ar}',
                          style: TextStyle(color: HexColor('#24688F')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 1,
                          width: double.infinity,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment:lang == 'en' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      Text(lang == 'en' ? 'Fees' : 'التكلفه'),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          '${widget.snapshot['fee']}  ${lang == 'en' ? 'EGP':'جنيه مصرى'}',
                          style: TextStyle(color: HexColor('#24688F')),
                          textDirection: lang == 'en' ? TextDirection.ltr : TextDirection.rtl,

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 1,
                          width: double.infinity,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        if (isChecked) {
                          if (_formkey.currentState!.validate()) {
                            await _saveData();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => checkout()));
                          }
                        } else {
                          await _saveData();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => checkout()));
                        }
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Select Payment Method' : 'اختار وسيله الدفع',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: HexColor("#1C81AB"),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    width: 250,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        if (!isChecked ||
                            (isChecked && _formkey.currentState!.validate())) {
                          await _saveData();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => Home_page()));
                          final snackBar = SnackBar(
                              content: Text(
                                'Reservation Added Successfully',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black.withOpacity(.7));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        lang == 'en' ? 'Add another Booking' : 'اضف حجز اخر',
                        textDirection: lang == 'en' ? TextDirection.ltr :TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _saveData() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var first_name = await sharedPreferences.getUser('first_name');
    var last_name = await sharedPreferences.getUser('last_name');
    var name = '$first_name $last_name';
    var phone = await sharedPreferences.getUser('phone');

    Map<String, dynamic> Date =
    widget.reserv_type == 'laboratory'?
    {
      'reservation type': 'laboratory',
      'patient name': isChecked ? _namecontroller.text : name,
      'patient phone': isChecked ? _phonecontroller.text : phone,
      'test name-en': widget.snapshot['title-en'],
      'test name-ar': widget.snapshot['title-ar'],
      'test id': widget.snapshot['id'],
      'appointments': widget.appointment,
      'appointments ar': widget.appointment_ar,
      'fees': widget.snapshot['fee'],
      'user id': uid,
    }:
    {
      'reservation type': 'scan',
      'patient name': isChecked ? _namecontroller.text : name,
      'patient phone': isChecked ? _phonecontroller.text : phone,
      'scan name-en': widget.snapshot['title-en'],
      'scan name-ar': widget.snapshot['title-ar'],
      'scan id': widget.snapshot['id'],
      'appointments': widget.appointment,
      'appointments ar': widget.appointment_ar,
      'fees': widget.snapshot['fee'],
      'user id': uid,
    };
    String encodedMap = json.encode(Date);
    await sharedPreferences.set(encodedMap);
  }

  Color getColor(Set<MaterialState> states) {
    if (isChecked) {
      return HexColor('#1C81AB');
    }
    return HexColor('#4E4E50');
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
          lang == 'en' ? "Complete Reservation" : "استكمال الموعد",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
