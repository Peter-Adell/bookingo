import 'dart:convert';

import 'package:bookingo/sharedPreferences/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'checkout.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  var lang = sharedPreferences.getUser('lang');

  var list = [];
  var listkeys = [];

  var Total = 0.0;
  bool isData = true;
  bool isCheckError = false;
  var keys =  sharedPreferences.getKeys();

  initState() {
    _getData();
  }

  _getData() async {
    var keys = await sharedPreferences.getKeys();
    if (keys.isNotEmpty) {
      var Listkeys = keys.toList();

      for (var i in Listkeys) {
        if (i != 'first_name' &&
            i != 'last_name' &&
            i != 'phone' &&
            i != 'city' &&
            i != 'imgUrl' &&
            i != 'email' &&
            i != 'active balance' &&
            i != 'pending balance' &&
            i != 'gender' &&
            i != 'userid'&&
            i != 'lang') {
          var result = await sharedPreferences.get(i);
          if (result != null) {
            Map<String, dynamic> decodedMap = json.decode(result);

            setState(() {
              list.add(decodedMap);
              listkeys.add(i);
              Total += double.parse(decodedMap['fees']);
            });
          }
          setState(() {
            isData = true;
          });
        }
      }
    }
    if(list.isEmpty){
      setState(() {
        isData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: _buildappbar(),
      ),
      body: isData
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (item) async {
                              var id = listkeys[i];

                              await sharedPreferences.delete('$id');
                              setState(() {
                                Total -= double.parse(list[i]['fees']);
                              });
                              list.removeAt(i);
                              listkeys.removeAt(i);
                              if (list.isEmpty) {
                                setState(() {
                                  isData = false;
                                });
                              }
                              final snackBar = SnackBar(
                                  content: Text(
                                    'Item deleted',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Colors.black.withOpacity(.7));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: reserv_list(context, list[i]));
                      }),
                ],
              ),
            )
          : Center(child: Text('cart is empty')),
      bottomNavigationBar: Container(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              padding: EdgeInsets.symmetric(horizontal: 8),
              child:lang == "en" ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child:
                    Text(
                      'Total: $Total   EGP',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  isCheckError
                      ? Text(
                          'Please book an appointment first',
                          style:
                              TextStyle(fontSize: 14, color: Colors.redAccent),
                        )
                      : Container()
                ],
              )
              :Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  isCheckError
                      ? Text(
                  'يرجى حجز موعد أولا',
                    style:
                    TextStyle(fontSize: 14, color: Colors.redAccent),
                  )
                      : Container(),
                  SizedBox(width: 20,),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child:
                    Row(
                      children: [
                        Text(
                          'جنيه مصرى',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          '$Total',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '  : المجموع',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                      ],
                    )
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (list.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => checkout()));
                    } else {
                      setState(() {
                        isCheckError = true;
                      });
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HexColor('#1C81AB'),
                        border: Border.all(color: HexColor('#C4C4C4')),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "${lang == "en" ? "Check Out" : "احجز الان"}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget reserv_list(context, snapshot) {

    return snapshot['reservation type'] == 'clinics'
        ? Container(
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"), fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 40, top: 20, bottom: 10, right: 40),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${lang == "en" ? "Patient Name" : "اسم المريض"} : ${snapshot['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == "en" ? "Phone Num" : "رقم الهاتف"}  : ${snapshot['patient phone']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        lang == 'en' ? "Dr: ${snapshot['doctor name']}" : "د : ${snapshot['doctor name ar']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        lang == 'en' ? "Specialization  : ${snapshot['specialization']}" : "التخصص  : ${snapshot['specialization ar']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == "en" ? "Clinic number" : "رقم العياده"}  : ${snapshot['clinic num']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == "en" ? "fee" : "التكلفه"}  : ${snapshot['fees']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : snapshot['reservation type'] == 'laboratory'
        ? Container(
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"), fit: BoxFit.fill),
      ),
      child: Container(
        margin:
        EdgeInsets.only(left: 40, top: 20, bottom: 10, right: 40),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${lang == "en" ? "Patient Name" : "اسم المريض"} : ${snapshot['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == "en" ? "Phone Num" : "رقم الهاتف"}  : ${snapshot['patient phone']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == "en" ? "reservation type : Laboratory" : "نوع الحجز : المعمل"}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                          "${lang == "en" ? "Test Name : ${snapshot['test name-en']}" : "اسم التحليل : ${snapshot['test name-ar']}"}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        lang == 'en' ? "appointments : ${snapshot['appointments']}" : "الموعد : ${snapshot['appointments ar']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        lang == 'en' ? "Fees: ${snapshot['fees']} EGP" : "الرسوم :  ${snapshot['fees']} جنيه مصرى",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : snapshot['reservation type'] == 'scan'
        ? Container(
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(
            left: 40, top: 20, bottom: 10, right: 40),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${lang == 'en' ? 'Patient name':'اسم المريض'} : ${snapshot['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == 'en' ? 'Phone Num':'رقم المريض'} : ${snapshot['patient phone']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == 'en' ? "reservation type : Scan":'نوع الحجز: مركز الاشعه'}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        "${lang == 'en' ? "scan Name : ${snapshot['scan name-en']}":'اسم الاشعه  : ${snapshot['scan name-ar']}'}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        lang == 'en' ? "appointments : ${snapshot['appointments']}" : "الموعد : ${snapshot['appointments ar']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      Text(
                        lang == 'en' ? "Fees: ${snapshot['fees']} EGP" : "الرسوم :  ${snapshot['fees']} جنيه مصرى",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : Container();
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
          sharedPreferences.getUser('lang') == 'en' ? "Checkout" : "الدفع",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
