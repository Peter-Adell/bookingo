import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Home.dart';
import '../chatbot/chatbot.dart';
import '../menu/edit_profile.dart';
import 'package:bookingo/sharedPreferences/sharedPreferences.dart';



class Booked extends StatefulWidget {
  final list ;
  const Booked({Key? key, required this.list}) : super(key: key);

  @override
  State<Booked> createState() => _BookedState();
  
}

class _BookedState extends State<Booked> {
  var lang = sharedPreferences.getUser('lang');

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
            child: Column(
              children: [
                body(),
                SizedBox(height: 60),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: HexColor("#1C81AB"),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  width: 250,
                  height: 45,
                  child: TextButton(
                    onPressed: ()  {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder)=>Home_page()));
                    },
                    style: TextButton.styleFrom(primary: Colors.white),
                    child: Text(
                      'Back To Home',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(context),
        )
    );

  }
  Widget body(){
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (context, i) {
          return reserv_list(context, widget.list[i]);
        });
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
          " booked successfully",
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
