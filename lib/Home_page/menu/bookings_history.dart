import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bookingo/sharedPreferences/sharedPreferences.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Home.dart';
import '../ratePage.dart';
import 'edit_profile.dart';

class bookings_history extends StatefulWidget {

  const bookings_history({Key? key}) : super(key: key);

  @override
  State<bookings_history> createState() => _bookings_historyState();
}

class _bookings_historyState extends State<bookings_history> {
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
            preferredSize: const Size.fromHeight(75.0),
            child: _buildappbar(),
          ),
          body:
            const _buildbody(),

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
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 20),
          icon: const Icon(
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
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
      ),
      title: Container(
        padding: const EdgeInsets.only(top: 10),
        child:  Text(
          sharedPreferences.getUser('lang') == 'en' ? "Bookings History" : "سجل الحجز",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
  var ref = FirebaseFirestore.instance.collection('reservations');
  var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          FutureBuilder(
                future: ref
                    .where('user id', isEqualTo: uid)
                    .where('status', whereIn: ['completed', 'canceled']).get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data.docs.length >0) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return reserv_list(context,snapshot.data.docs[i],snapshot.data.docs[i].id);
                        });
                  }else if(snapshot.connectionState == ConnectionState.done && snapshot.data.docs.length ==0 ){
                    return  Center(child:Text('no Data'));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),

    );
  }
  Widget reserv_list(context, snapshot, docid){
    var lang = sharedPreferences.getUser('lang');

    return snapshot['reservation type'] == 'clinics'
        ? Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 40, top: 20, bottom: 10),
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
                        "${lang == 'en' ? 'Patient name :': 'اسم المريض : '} ${snapshot['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                                .withOpacity(.5)),
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
                        lang == 'en' ? "Fees: ${snapshot['fees']} EGP" : "الرسوم :  ${snapshot['fees']} جنيه مصرى",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(
                            "${lang == 'en' ? 'Status': 'الحاله'}  :   ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                            ),
                          ),
                          snapshot['status'] == 'canceled' ?
                          Text(
                            '${lang == 'en' ? 'Canceled': 'ملغى'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red
                            ),
                          ):
                          Text(
                              '${lang == 'en' ? 'Completed': 'مكتمل'}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green
                              ))

                        ],
                      ),
                      const SizedBox(height: 10,),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.topRight,
                        child: QrImage(
                          data: snapshot['secKey'].toString(),
                          size: 200,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      snapshot['status'] == 'completed' &&
                          !snapshot['rate']
                          ?
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>RatePage(snapshot: snapshot,)));
                        },
                        child: Container(
                            width: 100,
                            height: 30,
                            margin:
                            EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  lang == 'en' ? 'Rate Services' : 'احجز',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: HexColor('4E4E50'),
                                  ),
                                ))),
                      )
                      :Container()
                      ,
                    ],
                  ),
                )
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
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 40, top: 20, bottom: 10),
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
                        "${lang == 'en' ? 'Patient name :': 'اسم المريض : '} ${snapshot['patient name']}",
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
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(
                            "${lang == 'en' ? 'Status': 'الحاله'}  :   ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                            ),
                          ),
                          snapshot['status'] == 'canceled' ?
                          Text(
                            '${lang == 'en' ? 'Canceled': 'ملغى'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red
                            ),
                          ):
                          Text(
                              '${lang == 'en' ? 'Completed': 'مكتمل'}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green
                              ))

                        ],
                      ),
                      const SizedBox(height: 10,),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.topRight,
                        child: QrImage(
                          data: snapshot['secKey'].toString(),
                          size: 200,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      snapshot['status'] == 'completed' &&
                          !snapshot['rate']
                          ?
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>RatePage(snapshot: snapshot,)));
                        },
                        child: Container(
                            width: 100,
                            height: 30,
                            margin:
                            EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  lang == 'en' ? 'Rate Services' : 'احجز',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: HexColor('4E4E50'),
                                  ),
                                ))),
                      )
                          :Container()
                      ,
                    ],
                  ),
                )
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
        margin: const EdgeInsets.only(left: 40, top: 20, bottom: 10),
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
                        "${lang == 'en' ? 'Patient name :': 'اسم المريض : '} ${snapshot['patient name']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                                .withOpacity(.5)),
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
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(
                            "${lang == 'en' ? 'Status': 'الحاله'}  :   ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                            ),
                          ),
                          snapshot['status'] == 'canceled' ?
                          Text(
                            '${lang == 'en' ? 'Canceled': 'ملغى'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red
                            ),
                          ):
                          Text(
                              '${lang == 'en' ? 'Completed': 'مكتمل'}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green
                              ))

                        ],
                      ),
                      const SizedBox(height: 10,),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.topRight,
                        child: QrImage(
                          data: snapshot['secKey'].toString(),
                          size: 200,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      snapshot['status'] == 'completed' &&
                          !snapshot['rate']
                          ?
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>RatePage(snapshot: snapshot,)));
                        },
                        child: Container(
                            width: 100,
                            height: 30,
                            margin:
                            EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  lang == 'en' ? 'Rate Services' : 'احجز',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: HexColor('4E4E50'),
                                  ),
                                ))),
                      )
                          :Container()
                      ,
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
                icon: const Icon(Icons.message_outlined,
                    color: Colors.white, size: 40)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => const Home_page()));
                },
                icon: const Icon(Icons.home_outlined, color: Colors.white, size: 40)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const edit_profile()));
                },
                icon: const Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
