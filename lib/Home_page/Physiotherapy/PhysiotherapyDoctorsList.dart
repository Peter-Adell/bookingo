import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../gsheets/sheets_api.dart';
import '../Home.dart';
import '../chatbot/chatbot.dart';
import '../menu/edit_profile.dart';
import '../clinics/Search.dart';
import '../clinics/booking/Choose_appoinment.dart';
import 'package:bookingo/sharedPreferences/sharedPreferences.dart';

import 'booking/Choose_appoinment.dart';

class PhysiotherapyDotcorList extends StatefulWidget {


  const PhysiotherapyDotcorList({Key? key,}) : super(key: key);

  @override
  State<PhysiotherapyDotcorList> createState() => _PhysiotherapyDotcorListState();
}

class _PhysiotherapyDotcorListState extends State<PhysiotherapyDotcorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: _buildappbar(),
      ),
      body: _buildbody(),
    );
  }
}

class _buildbody extends StatefulWidget {

  const _buildbody( {Key? key}) : super(key: key);

  @override
  State<_buildbody> createState() => _buildbodyState();
}

class _buildbodyState extends State<_buildbody> {
  var PhysiotherapyList = [];
  bool flg = false;

  initState() {
    get_data();
  }

  get_data() async {
    setState(() {
      flg = true;
    });
    final Doctors = await SheetsApi.getAllPhysiotherapy();
    for (var item in Doctors){
        setState(() {
          PhysiotherapyList.add(item);
        });
    }
    print(PhysiotherapyList);
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
          preferredSize: Size.fromHeight(70.0),
          child: _searchBar(),
        ),
        body: PhysiotherapyList.length > 0
            ? SingleChildScrollView(
            child:  ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: PhysiotherapyList.length,
                itemBuilder: (context, i) {
                  return List_Doctor(context, PhysiotherapyList[i]);
                })
        ): PhysiotherapyList.length == 0 && flg ?
        Center(child: CircularProgressIndicator())
            :Center(child: Text('no data')),
        bottomNavigationBar: BottomNavigationBar(context),
      ),
    );
  }
  Widget List_Doctor(context, snapshot) {

    double PlaceRate = double.parse(snapshot['star_num']);
    var lang =sharedPreferences.getUser('lang');

    var x1 = snapshot['Saturday'];
    var x2 = snapshot['Sunday'];
    var x3 = snapshot['Monday'];
    var x4 = snapshot['Tuesday'];
    var x5 = snapshot['Wednesday'];
    var x6 = snapshot['Thursday'];

    var days = "${x1 == '-----------' ? '':('Saturday' + ', ' )}"+
        "${x2 == '-----------' ? '':('Sunday' + ', ' )}"+
        "${x3 == '-----------' ? '':('Monday' + ', ' )}" +
        "${x4 == '-----------' ? '':('Tuesday' + ', ' )}" +
        "${x5 == '-----------' ? '':('Wednesday' + ', ' )}" +
        "${x6 == '-----------' ? '':'Thursday'}" ;

    var daysar = "${x1 == '-----------' ? '':('السبت' + ', ' )}"+
        "${x2 == '-----------' ? '':('الاحد' + ', ' )}"+
        "${x3 == '-----------' ? '':('الاثنين' + ', ' )}" +
        "${x4 == '-----------' ? '':('الثلاثاء' + ', ' )}" +
        "${x5 == '-----------' ? '':('الاربعاء' + ', ' )}" +
        "${x6 == '-----------' ? '':'الخميس'}" ;


    return Container(
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
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: ClipOval(
                        child: Image.network(
                          '${snapshot['image_url']}',
                          width: 55,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 15),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'en' ? "Dr: ${snapshot['name']}" : "د : ${snapshot['name_ar']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: HexColor('#4E4E50'),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${lang == 'en' ? snapshot['position'] : snapshot['position_ar']}",
                          style: TextStyle(
                            fontSize: 15,
                            color: HexColor('#4E4E50'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PlaceRate == 0
                            ? Icon(Icons.star_outline, color: Colors.grey,size: 15)
                            : PlaceRate > 0 && PlaceRate < .5
                            ? Icon(Icons.star_half_sharp, color: Colors.amber,size: 15)
                            : PlaceRate > .5
                            ? Icon(Icons.star_outlined, color: Colors.amber,size: 15)
                            : Container(),
                        PlaceRate <= 1
                            ? Icon(Icons.star_outline, color: Colors.grey,size: 15)
                            : PlaceRate > 1 && PlaceRate < 1.5
                            ? Icon(Icons.star_half_sharp, color: Colors.amber,size: 15)
                            : PlaceRate > 1.5
                            ? Icon(Icons.star_outlined, color: Colors.amber,size: 15)
                            : Container(),
                        PlaceRate <= 2
                            ? Icon(Icons.star_outline, color: Colors.grey,size: 15)
                            : PlaceRate > 2 && PlaceRate < 2.5
                            ? Icon(Icons.star_half_sharp, color: Colors.amber,size: 15)
                            : PlaceRate > 2.5
                            ? Icon(Icons.star_outlined, color: Colors.amber,size: 15)
                            : Container(),
                        PlaceRate <= 3
                            ? Icon(Icons.star_outline, color: Colors.grey,size: 15)
                            : PlaceRate > 3 && PlaceRate < 3.5
                            ? Icon(Icons.star_half_sharp, color: Colors.amber,size: 15)
                            : PlaceRate > 3.5
                            ? Icon(Icons.star_outlined, color: Colors.amber,size: 15)
                            : Container(),
                        PlaceRate <= 4
                            ? Icon(Icons.star_outline, color: Colors.grey,size: 15)
                            : PlaceRate > 4 && PlaceRate < 4.5
                            ? Icon(Icons.star_half_sharp, color: Colors.amber,size: 15)
                            : PlaceRate > 4.5
                            ? Icon(Icons.star_outlined, color: Colors.amber,size: 15)
                            : Container(),
                        SizedBox(width: 5),
                        Text("$PlaceRate / 5",
                            style: TextStyle(fontWeight: FontWeight.bold)),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/fee.png'),
                      SizedBox(width: 10),
                      Text(
                        lang == 'en' ? "Fees: ${snapshot['fee']} EGP" : "الرسوم :  ${snapshot['fee']} جنيه مصرى",
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor('#4E4E50'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset('assets/icons/time.png'),
                      SizedBox(width: 10),
                      Text(
                        lang == 'en' ? "Waiting Time: ${snapshot['wait_time']} Minutes": "وقت الانتظار :  ${snapshot['wait_time']} دقيقه",
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor('#4E4E50'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    lang == 'en' ? "${days}" : "${daysar}",
                    style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#4E4E50'),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              Choose_appoinmentPhysiotherapy(snapshot: snapshot)));
                },
                child: Container(
                    width: 135,
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
                          lang == 'en' ? 'Book' : 'احجز',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: HexColor('4E4E50'),
                          ),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _buildappbar extends StatelessWidget {


  const _buildappbar({Key? key}) : super(key: key);

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
          "${lang == 'ar' ? 'العلاج الطبيعى' : 'Physiotherapy' }",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _searchBar extends StatelessWidget {
  const _searchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController();
    var lang =sharedPreferences.getUser('lang');

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: AppBar(
        leadingWidth: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 65,
          padding: EdgeInsets.only(top: 15),
          margin: EdgeInsets.only(bottom: 10),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
                label: Text(lang == 'en' ? "Search for Doctor": "ابحث عن دكتور"),
                labelStyle: TextStyle(color: Colors.black.withOpacity(.6)),
                suffixIcon:
                IconButton(icon: Icon(Icons.search, color: Colors.black.withOpacity(.5)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>SearchDoc(text: _textController.text,category: 'Physiotherapy',)));
                  },),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0,
                  ),
                ),
                fillColor: Colors.white,
                filled: true),
            style: TextStyle(backgroundColor: Colors.white),
          ),
        ),
      ),
    );
  }
}


Widget BottomNavigationBar(context) {
  return Container(
      decoration: const BoxDecoration(
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
