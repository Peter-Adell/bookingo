import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../gsheets/sheets_api.dart';
import '../../sharedPreferences/sharedPreferences.dart';
import '../Home.dart';
import '../chatbot/chatbot.dart';
import '../menu/edit_profile.dart';
import 'booking/Choose_appoinment.dart';


class SearchLab extends StatefulWidget {
  final text;

  const SearchLab({Key? key, required this.text,}) : super(key: key);

  @override
  State<SearchLab> createState() => _SearchLabState();
}

class _SearchLabState extends State<SearchLab> {
  var TestList = [];
  bool flg = false;

  initState() {
    get_data();
  }

  get_data() async {
    setState(() {
      flg = true;
    });
    final Scans = await SheetsApi.getAllTests();
    for (var item in Scans){
      if((item['title-ar'] == widget.text || item['title-en'] == widget.text)){
        setState(() {
          TestList.add(item);
        });
      }
    }
    setState(() {
      flg = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: _buildappbar(),
      ),
      body: TestList.length > 0
          ? SingleChildScrollView(
          child:  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: TestList.length,
              itemBuilder: (context, i) {
                return List_Test(context, TestList[i]);
              })
      ): TestList.length == 0 && flg ?
      Center(child: CircularProgressIndicator())
          :Center(child: Text('no Result')),
      bottomNavigationBar: BottomNavigationBar(context),
    );
  }
}
Widget List_Test(context, snapshot) {
  var lang =sharedPreferences.getUser('lang');

  return Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
    decoration: BoxDecoration(
      border: Border.all(color: HexColor('#1C81AB'), width: 2),
      borderRadius: BorderRadius.all(Radius.circular(47)),
    ),
    child: Column(
      children: [
        Text(
          '${lang == 'en' ? snapshot['title-en'] : snapshot['title-ar']}',
          style: TextStyle(
              fontSize: 17,
              color: HexColor('#4E4E50')
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Container(height: 40, width: 50, child: Image(image: AssetImage('assets/Laboratory_icon.png'),)),
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
                      textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,
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
                      "${lang == 'en' ? "Price":"الرسوم"} :  ${snapshot['fee']} ${lang == 'en' ? "EGB" : "جنيه مصرى"}",
                      textDirection: lang == 'en' ? TextDirection.ltr:TextDirection.rtl,

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
                      builder: (context) => Choose_appoinment(snapshot: snapshot, reserv_type: 'Laboratory',),
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
            sharedPreferences.getUser('lang') == 'en' ? "Search" : "بحث",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
