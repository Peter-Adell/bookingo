import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../gsheets/sheets_api.dart';
import '../../sharedPreferences/sharedPreferences.dart';
import '../Home.dart';
import '../chatbot/chatbot.dart';
import '../menu/edit_profile.dart';
import 'booking/Choose_appoinment.dart';


class SearchDoc extends StatefulWidget {
  final text;
  final category;

  const SearchDoc({Key? key, required this.text, required this.category}) : super(key: key);

  @override
  State<SearchDoc> createState() => _SearchDocState();
}

class _SearchDocState extends State<SearchDoc> {
  var doctorList = [];
  bool flg = false;

  initState() {
    get_data();
  }

  get_data() async {
    setState(() {
      flg = true;
    });
    final Doctors = await SheetsApi.getAllDoctor();
    for (var item in Doctors){
      if( item['specialization'] == widget.category && (item['name'] == widget.text || item['name_ar'] == widget.text)){
        setState(() {
          doctorList.add(item);
        });
      }
      setState(() {
        flg = false;
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
      body: doctorList.length > 0
          ? SingleChildScrollView(
          child:  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorList.length,
              itemBuilder: (context, i) {
                return List_Doctor(context, doctorList[i]);
              })
      ): doctorList.length == 0 && flg ?
      Center(child: CircularProgressIndicator())
          :Center(child: Text('no Result')),
      bottomNavigationBar: BottomNavigationBar(context),
    );
  }
}
Widget List_Doctor(context, snapshot) {
  double PlaceRate = double.parse(snapshot['star_num']);
  var lang =sharedPreferences.getUser('lang');

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
                  child: Image.network(
                    '${snapshot['image_url']}',
                    width: 55,
                    height: 45,
                    fit: BoxFit.cover,
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
                  lang == 'en' ? "${snapshot['first_date']}" : "${snapshot['first_date_ar']}",
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
                            Choose_appoinment(snapshot: snapshot)));
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
                        lang == 'en' ? 'book' : 'احجز',
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
