import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pay/pay.dart';
import 'package:intl/intl.dart' as dddd;

import '../../component/loading.dart';
import '../../gsheets/sheets_api.dart';
import '../../sharedPreferences/sharedPreferences.dart';
import 'Booked.dart';

class checkout extends StatefulWidget {
  const checkout({Key? key}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  var list = [];
  var listkeys = [];
  var Total = 0.0;
  var fee;
  var fees;
  var rest = 0.0;
  bool isData = true;
  var activebalance =
      double.parse(sharedPreferences.getUser('active balance')!);
  var fe;

  var lang = sharedPreferences.getUser('lang');

  bool isChecked = false;
  bool? isPromoErorr = null;
  TextEditingController _promocodecontroller = TextEditingController();

  bool flg = false;
  bool _switchValue = false;

  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  initState() {
    _getData();
  }

  _getData() async {
    var keys = await sharedPreferences.getKeys();
    if (keys.isNotEmpty) {
      listkeys = keys.toList();
      for (var i in listkeys) {
        if (i != 'first_name' &&
            i != 'last_name' &&
            i != 'phone' &&
            i != 'city' &&
            i != 'imgUrl' &&
            i != 'email' &&
            i != 'active balance' &&
            i != 'pending balance' &&
            i != 'gender' &&
            i != 'userid' &&
            i != 'lang') {
          var result = await sharedPreferences.get(i);
          if (result != null) {
            Map<String, dynamic> decodedMap = json.decode(result);
            setState(() {
              list.add(decodedMap);
              Total += double.parse(decodedMap['fees']);
            });
          }
        }
      }
      if (activebalance < 0) {
        setState(() {
          Total += activebalance.abs();
        });
      }
    } else {
      setState(() {
        isData = false;
      });
    }
    print('total = $Total');
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: _buildappbar(),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        return reserv_list(context, list[i]);
                      }),
                ),
                Container(
                  height: lang == 'en' ? 500 : 450,
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        lang == 'en'
                                            ? 'Use your wallet balance first:'
                                            : 'استخدم رصيد محفظتك اولا',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: HexColor('#4E4E50'),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Transform.scale(
                                              scale: 0.9,
                                              child: CupertinoSwitch(
                                                activeColor:
                                                    HexColor('#1C81AB'),
                                                value: _switchValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _switchValue = value;
                                                  });
                                                  if (value &&
                                                      activebalance > 0) {
                                                    var activBalance = double
                                                        .parse(sharedPreferences
                                                            .getUser(
                                                                'active balance')!);
                                                    fe = Total - activBalance;

                                                    if (isChecked) {
                                                      setState(() {
                                                        fees =
                                                            fee - activBalance;
                                                      });
                                                    } else if (!isChecked) {
                                                      setState(() {
                                                        fees = Total -
                                                            activBalance;
                                                      });
                                                    }
                                                    if (fees < 0) {
                                                      rest = fees.abs();
                                                      print('rest = $rest');
                                                    } else {
                                                      rest = activBalance -
                                                          (Total - fees);
                                                      print('rest = $rest');
                                                    }
                                                  } else {
                                                    setState(() {
                                                      fe = Total;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          lang == 'en'
                                              ? Text(
                                                  'Wallet : ${sharedPreferences.getUser('active balance')} EGP',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                )
                                              : Text(
                                                  'المحفظه : ${sharedPreferences.getUser('active balance')} جنيه',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                ),
                                          _switchValue
                                              ? Text(
                                                  'الباقى : ${rest} جنيه',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        isPromoErorr = null;
                                        fee = Total;
                                      });
                                      if (!isChecked) {
                                        setState(() {
                                          flg = false;
                                        });
                                      }
                                    },
                                  ),
                                  Text(
                                    lang == 'en'
                                        ? 'Add promo code'
                                        : 'اضف كوبون الخصم',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: HexColor('#4E4E50')),
                                  ),
                                ],
                              ),
                              TextFormField(
                                  enabled: isChecked,
                                  controller: _promocodecontroller,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    hintText: lang == 'en'
                                        ? 'Enter Promo code'
                                        : 'ادخل كوبون خصم',
                                    hintStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#205072")
                                            .withOpacity(0.5)),
                                    suffix: InkWell(
                                      onTap: () {
                                        _chech_promo();
                                      },
                                      child: Container(
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 4,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                              child: Text(
                                            lang == 'en' ? 'Check' : 'تحقق',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: HexColor('4E4E50'),
                                            ),
                                          ))),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.4)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.4)),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      print('value=$value');
                                      return 'Please Fill last name Input';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 10),
                              isPromoErorr == true
                                  ? Container(
                                      alignment: lang == 'en'
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Text(
                                        lang == 'en'
                                            ? 'promo code unavailable'
                                            : 'كوبون الخصم غير صالح',
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ))
                                  : isPromoErorr == false
                                      ? Container(
                                          child: Container(
                                              alignment: lang == 'en'
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                              child: Text(
                                                lang == 'en'
                                                    ? 'promo code activated'
                                                    : 'كوبون الخصم فعال',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )),
                                        )
                                      : Container(),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.black.withOpacity(0.4)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: lang == 'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: lang == 'en'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${"Total fees"} :  ${!isChecked && !_switchValue ? "${Total < 0 ? 0 : Total}" : isChecked && !_switchValue ? "${fee < 0 ? 0 : fee}" : !isChecked && _switchValue ? "${fe < 0 ? 0 : fe}" : "${fees < 0 ? 0 : fees}"} ${"EGP"}",
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              isChecked
                                                  ? SizedBox(width: 20)
                                                  : Container(),
                                              flg
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                          Text("${Total} EGP",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              )),
                                                          Container(
                                                            height: 1.5,
                                                            width: 60,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          )
                                                        ])
                                                  : Container(),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              flg
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                          Text("${Total} جنيه",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              )),
                                                          Container(
                                                            height: 1.5,
                                                            width: 60,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          )
                                                        ])
                                                  : Container(),
                                              flg
                                                  ? SizedBox(width: 10)
                                                  : Container(),
                                              Text(
                                                  "${"مجموع التكلفه"} :  ${!isChecked ? Total : fee} ${"جنيه مصرى"}",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          )),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: 250,
                              height: 45,
                              child: TextButton(
                                onPressed: () async {
                                  _submit('offline');
                                },
                                style:
                                    TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  lang == 'en'
                                      ? 'pay in hospital'
                                      : 'ادفع فى المستشفى',
                                  textDirection: lang == 'en'
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            GooglePayButton(
                              width: 250,
                              height: 45,
                              paymentConfigurationAsset: 'gpay.json',
                              paymentItems: _paymentItems,
                              style: GooglePayButtonStyle.black,
                              type: GooglePayButtonType.pay,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: onGooglePayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void onGooglePayResult(paymentResult) async {
    _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: !isChecked && !_switchValue
            ? '${Total < 0 ? 0 : Total}'
            : isChecked && !_switchValue
                ? '${fee < 0 ? 0 : fee}'
                : !isChecked && _switchValue
                    ? '${fe < 0 ? 0 : fe}'
                    : '${fees < 0 ? 0 : fees}',
        status: PaymentItemStatus.final_price,
      )
    ];
    debugPrint(paymentResult.toString());
    await _submit('online');
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
                              lang == 'en'
                                  ? "Dr: ${snapshot['doctor name']}"
                                  : "د : ${snapshot['doctor name ar']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(.5)),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: 300),
                              child: Text(
                                lang == 'en'
                                    ? "Specialization  : ${snapshot['position']}"
                                    : "التخصص  : ${snapshot['position ar']}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.5)),
                                maxLines: 1,
                              ),
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
                                  lang == 'en'
                                      ? "appointments : ${snapshot['appointments']}"
                                      : "الموعد : ${snapshot['appointments ar']}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(.5)),
                                ),
                                Text(
                                  lang == 'en'
                                      ? "Fees: ${snapshot['fees']} EGP"
                                      : "الرسوم :  ${snapshot['fees']} جنيه مصرى",
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${lang == 'en' ? 'Patient name' : 'اسم المريض'} : ${snapshot['patient name']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    Text(
                                      "${lang == 'en' ? 'Phone Num' : 'رقم المريض'} : ${snapshot['patient phone']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    Text(
                                      "${lang == 'en' ? "reservation type : Scan" : 'نوع الحجز: مركز الاشعه'}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    Text(
                                      "${lang == 'en' ? "scan Name : ${snapshot['scan name-en']}" : 'اسم الاشعه  : ${snapshot['scan name-ar']}'}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    Text(
                                      lang == 'en'
                                          ? "appointments : ${snapshot['appointments']}"
                                          : "الموعد : ${snapshot['appointments ar']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    Text(
                                      lang == 'en'
                                          ? "Fees: ${snapshot['fees']} EGP"
                                          : "الرسوم :  ${snapshot['fees']} جنيه مصرى",
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

  Color getColor(Set<MaterialState> states) {
    if (isChecked) {
      return HexColor('#1C81AB');
    }
    return HexColor('#4E4E50');
  }

  _chech_promo() {
    if (_promocodecontroller.text == "new" && fee == Total) {
      print(fee);
      print('=========================================');

      setState(() {
        fee = fee - (fee * (0.3));
        fees = fee - double.parse(sharedPreferences.getUser('active balance')!);
        isPromoErorr = false;
        flg = true;
      });
    } else if (_promocodecontroller.text != "new") {
      setState(() {
        isPromoErorr = true;
        fee = Total;
        flg = false;
      });
    }
  }

   _genSecKey(){
    var rng = Random();
    var secKey = rng.nextInt(9999);
    if(secKey < 1000){
      return secKey+1000 ;
    }
    return secKey ;
  }

  _submit(paymentMethod) async {
    showLoading(context);
    var id;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    for (var i = 0; i < list.length; i++) {
      if (list[i]['reservation type'] == 'clinics') {
        var fee;
        if (_switchValue) {
          var x = activebalance / list.length;
          fee = list[i]['fees'] - x;
        }
        var secKey = _genSecKey();

        var result =
            await FirebaseFirestore.instance.collection('reservations').add({
          'patient name': list[i]['patient name'],
          'patient phone': list[i]['patient phone'],
          'city': sharedPreferences.get('city'),
          'appointments': list[i]['appointments'],
          'appointments ar': list[i]['appointments ar'],
          'clinic num': list[i]['clinic num'],
          'detection num': list[i]['detection num'],
          'doctor name': list[i]['doctor name'],
          'doctor name ar': list[i]['doctor name ar'],
          'doctor id': list[i]['doctor id'],
          'specialization': list[i]['specialization'],
          'specialization ar': list[i]['specialization ar'],
          'position': list[i]['position'],
          'position ar': list[i]['position ar'],
          'fees': list[i]['fees'],
          'payable': fee ?? list[i]['fees'],
          'promo code': _promocodecontroller.text,
          'reservation type': list[i]['reservation type'],
          'user id': uid,
          'rate': false,
          'secKey': secKey,
          'status': 'active',
          'payment method': paymentMethod,
          'day': dddd.DateFormat('EEEE').format(DateTime.now()),
          'hour': dddd.DateFormat('HH').format(DateTime.now()),
        });
        id = result.id;
        await FirebaseFirestore.instance.collection('reservations').doc(id).update({
          'doc id': id,
        });

        if(list[i]['specialization'] != 'Physiotherapy'){
          var y = list[i]['doctor id'];
          var x = await SheetsApi.getDoctorById(int.parse(y));
          print("list[i]['appointments'] = ${list[i]['appointments']}");

          var date = list[i]['appointments'] == x['first_date'] ? 'first_date':
          list[i]['appointments'] == x['second_date'] && list[i]['appointments'][0] == x['second_date'][0][0] ? 'second_date':
          list[i]['appointments'] == x['third_date'] && list[i]['appointments'][0] == x['third_date'][0] ? 'third_date':
          list[i]['appointments'] == x['fourth_date'] && list[i]['appointments'][0] == x['fourth_date'][0] ? 'fourth_date':
          list[i]['appointments'] == x['fifth_date'] && list[i]['appointments'][0] == x['fifth_date'][0]? 'fifth_date':'';
          var num = date +'_reservNum';

          var z = int.parse(x[num]);

          var nw = z+1;
           await SheetsApi.updateDoctorCell(
               id: int.parse(y), Key: num, value: nw);
         }

      }
      else if (list[i]['reservation type'] == 'laboratory') {
        if (_switchValue) {
          var x = activebalance / list.length;
          fee = list[i]['fees'] - x;
        }
        var secKey = _genSecKey();

        var result =
            await FirebaseFirestore.instance.collection('reservations').add({
          'patient name': list[i]['patient name'],
          'patient phone': list[i]['patient phone'],
          'city': sharedPreferences.get('city'),
          'appointments': list[i]['appointments'],
          'appointments ar': list[i]['appointments ar'],
          'test name-en': list[i]['test name-en'],
          'test name-ar': list[i]['test name-ar'],
          'test id': list[i]['test id'],
          'fees': list[i]['fees'],
          'payable': fee ?? list[i]['fees'],
          'promo code': _promocodecontroller.text,
          'reservation type': list[i]['reservation type'],
          'user id': uid,
              'rate': false,
              'secKey': secKey,
          'status': 'active',
          'payment method': paymentMethod,
          'day': dddd.DateFormat('EEEE').format(DateTime.now()),
          'hour': dddd.DateFormat('HH').format(DateTime.now()),
        });
        id = result.id;
        await FirebaseFirestore.instance.collection('reservations').doc(id).update({
          'doc id': id,
        });
      }
      else if (list[i]['reservation type'] == 'scan') {
        var fee;
        if (_switchValue) {
          var x = activebalance / list.length;
          fee = list[i]['fees'] - x;
        }
        var secKey = _genSecKey();

        var result =
            await FirebaseFirestore.instance.collection('reservations').add({
          'patient name': list[i]['patient name'],
          'patient phone': list[i]['patient phone'],
          'city': sharedPreferences.get('city'),
          'appointments': list[i]['appointments'],
          'appointments ar': list[i]['appointments ar'],
          'scan name-en': list[i]['scan name-en'],
          'scan name-ar': list[i]['scan name-ar'],
          'scan id': list[i]['scan id'],
          'fees': list[i]['fees'],
          'payable': fee ?? list[i]['fees'],
          'promo code': _promocodecontroller.text,
          'reservation type': list[i]['reservation type'],
          'user id': uid,
              'rate': false,
              'secKey': secKey,
          'status': 'active',
          'payment method': paymentMethod,
          'day': dddd.DateFormat('EEEE').format(DateTime.now()),
          'hour': dddd.DateFormat('HH').format(DateTime.now()),
        });
        id = result.id;
        await FirebaseFirestore.instance.collection('reservations').doc(id).update({
          'doc id': id,
        });
      }
    }

    if (_switchValue) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'active balance': rest,
      });
    }
    await sharedPreferences.clear();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences.setUser(
          'first_name', snapshot.data.call()!['first name']);
      await sharedPreferences.setUser(
          'last_name', snapshot.data.call()!['last name']);
      await sharedPreferences.setUser('phone', snapshot.data.call()!['phone']);
      await sharedPreferences.setUser('city', snapshot.data.call()!['city']);
      await sharedPreferences.setUser(
          'imgUrl', snapshot.data.call()!['image url']);
      await sharedPreferences.setUser('email', snapshot.data.call()!['email']);
      await sharedPreferences.setUser(
          'gender', snapshot.data.call()!['gender']);
      await sharedPreferences.setUser(
          'active balance', snapshot.data.call()!['active balance'].toString());
      await sharedPreferences.setUser('pending balance',
          snapshot.data.call()!['pending balance'].toString());
      await sharedPreferences.setUser(
          'userid', snapshot.data.call()!['userid']);
      await sharedPreferences.setUser('lang', snapshot.data.call()!['lang']);
    });

    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (builder) => Booked(
                  list: list,
                )));
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
          lang == 'en' ? "Payment method" : "وسيله الدفع",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
