import 'package:bookingo/Home_page/scan_center/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../gsheets/sheets_api.dart';
import '../Home.dart';
import '../Laboratory/booking/Choose_appoinment.dart';
import '../chatbot/chatbot.dart';
import '../menu/edit_profile.dart';
import '../../sharedPreferences/sharedPreferences.dart';


class scanCenter_home extends StatefulWidget {
  const scanCenter_home({Key? key}) : super(key: key);

  @override
  State<scanCenter_home> createState() => _scanCenter_homeState();
}

class _scanCenter_homeState extends State<scanCenter_home> {
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
        body: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: _searchBar(),
          ),
          body: SingleChildScrollView(child: _buildbody()),
        ),
        bottomNavigationBar: BottomNavigationBar(context),
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

  var ScansList = [];
  bool flg = false;

  initState() {
    get_data();
  }

  get_data() async {
    setState(() {
      flg = true;
    });
    final Scans = await SheetsApi.getAllScans();
    for (var item in Scans){
        setState(() {
          ScansList.add(item);
        });

    }
    setState(() {
      flg = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child:Column(
        children: [
          ScansList.length > 0
              ? SingleChildScrollView(
              child:  Column(
                children: [
                  sharedPreferences.getUser('lang') == 'en' ? Text('Please bring the prescription to the hospital'):
                  Text('يرجى احضار الروشتة إلى المستشفى'),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ScansList.length,
                      itemBuilder: (context, i) {
                        return List_Scans(context, ScansList[i]);
                      }),
                ],
              )
          ): ScansList.length == 0 && flg ?
          Center(child: CircularProgressIndicator())
              :Center(child: Text('no data')),
        ],
      ),
    );
  }
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          padding: const EdgeInsets.only(top: 20.0),
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Colors.transparent,
      elevation: 10,
      flexibleSpace: Container(
        child: Container(alignment: Alignment.bottomCenter),
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
      ),
      title:  Padding(
        padding: EdgeInsets.only(right: 40, top: 20),
        child: Center(
          child: Text(
            sharedPreferences.getUser('lang') == 'en' ? "Scan Center Reservation" : "حجز الاشعه",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _searchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController();
    var lang = sharedPreferences.getUser('lang');

    return Container(
      height: 65,
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: TextField(
        controller: _textController,

        decoration: InputDecoration(

            label: Text(lang == 'en' ? "Search by ray type" : "البحث عن طريق نوع الاشعه"),
            labelStyle: TextStyle(color: Colors.black.withOpacity(.6)),
            suffixIcon:
            IconButton(icon: Icon(Icons.search, color: Colors.black.withOpacity(.5)),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>SearchScan(text: _textController.text, )));
              },),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.white,
                width: 0,
              ),
            ),
            fillColor: Colors.white,
            filled: true),
        style: TextStyle(backgroundColor: Colors.white),
      ),
    );
  }
}

Widget List_Scans(context, snapshot) {
  var lang = sharedPreferences.getUser('lang');

  return Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      border: Border.all(color: HexColor('#1C81AB'), width: 2),
      borderRadius: BorderRadius.all(Radius.circular(47)),
    ),
    child: Column(
      children: [
        Text(
          '${lang == 'en' ? snapshot['title-en'] : snapshot['title-ar']}',
        textDirection: lang == 'en' ? TextDirection.ltr :TextDirection.rtl
        ,style: TextStyle(
            fontSize: 17,
            color: HexColor('#4E4E50')
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Container(height: 40, width: 50, child: Image(image: AssetImage('assets/scan_icon/X-rays.png'),)),
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
                      "${lang == 'en' ? "Waiting Time" : "وقت الانتظار"} :  ${snapshot['wait_time']} ${lang == 'en' ? "Minutes" : "دقيقه"}",
                      style:
                          TextStyle(fontSize: 15, color: HexColor('#4E4E50')),
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
                      "${lang == 'en' ? "Price":"الرسوم"} :  ${snapshot['fee']} ${lang == 'en' ? "EGP" : "جنيه مصرى"}",
                      style:
                          TextStyle(fontSize: 15, color: HexColor('#4E4E50')),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => Choose_appoinment(snapshot: snapshot,reserv_type: 'scan'),
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: HexColor('#4E4E50'), width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  lang == 'en' ? 'Book' : 'احجز',
                  style: TextStyle(
                      fontSize: 17,
                      color: HexColor('#4E4E50'),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
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
                       MaterialPageRoute(builder: (builder) => edit_profile(

                      )));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
