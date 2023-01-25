import 'package:bookingo/Home_page/chatbot/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../sharedPreferences/sharedPreferences.dart';

import '../Home.dart';
import '../menu/edit_profile.dart';
import 'doctor_list.dart';

class clinic_home extends StatefulWidget {
  const clinic_home({Key? key}) : super(key: key);

  @override
  State<clinic_home> createState() => _clinic_homeState();
}

class _clinic_homeState extends State<clinic_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: _buildappbar(),
      ),
      body: SingleChildScrollView(child: _buildbody()),
      bottomNavigationBar: BottomNavigationBar(context),

    );
  }
}

class _buildbody extends StatefulWidget {
  const _buildbody({Key? key}) : super(key: key);

  @override
  State<_buildbody> createState() => _buildbodyState();
}

class _buildbodyState extends State<_buildbody> {
  var lang =sharedPreferences.getUser('lang');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: lang == 'en' ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(lang == 'en' ? "Specialties" : "التخصصات",
                  style:TextStyle(
                    color: HexColor('#4E4E50'),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ) ,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          categoryItem('assets/clinics_icon/dintistry_icon.png','Dintistry','اسنان',context),
          categoryItem('assets/clinics_icon/psychiarty_icon.png','Psychiarty','الطب النفسي',context),
          categoryItem('assets/clinics_icon/audiology_icon.png','Audiology','السمعيات',context),
          categoryItem('assets/clinics_icon/ophthalmology_icon.png','Ophthalmology','طب العيون',context),
          categoryItem('assets/clinics_icon/orthopedics_icon.png','Orthopedics','طب العظام',context),
          categoryItem('assets/clinics_icon/nose_icon.png','Ear,Nose and Throat','انف واذن وحنجرة',context),
          categoryItem('assets/clinics_icon/heart_icon.png','Cardiology and vascular disease','أمراض القلب والأوعية الدموية',context),
          categoryItem('assets/clinics_icon/chest_icon.png','Chest and respiratory','الصدر والجهاز التنفسي',context),
          categoryItem('assets/clinics_icon/hepatomegaly_icon.png','Hepatomegaly','تضخم الكبد',context),


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
            sharedPreferences.getUser('lang') == 'en' ? "Clinic Reservation" : "حجز العيادات",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


Widget categoryItem(icon, text,text_ar, context){
  var lang =sharedPreferences.getUser('lang');

  return Container(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder)=>DoctorList(category: text, category_ar: text_ar)));
            },
            child:
            lang == 'en' ?
            Row(
              children: [
                Image.asset(icon,width: 50,height: 50,),
                SizedBox(width: 10),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: 250
                  ),
                  child: Text (text,
                  style: TextStyle(
                    fontSize: 18,
                    color: HexColor('#4E4E50')
                  ),),
                ),
              ],
            )
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text (text_ar,
                  style: TextStyle(
                      fontSize: 20,
                      color: HexColor('#4E4E50')
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(width: 15),
                Image.asset(icon,width: 50,height: 50,),
              ],
            ),

          ),
          SizedBox(height: 10),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              margin: EdgeInsets.only(top: 5),
              height: 1.5,
              color: HexColor('#707070').withOpacity(.5),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
}

Widget BottomNavigationBar(context){
  return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            image: AssetImage("assets/footer_2.png"),
            fit: BoxFit.cover,
        ),
      ),
      height: 70,
      alignment:Alignment.topCenter,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => chatbot()));
            },
                icon: Image.asset('assets/icons/chatbot.png')
            ),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder)=> Home_page()));
            },
                icon: Icon(Icons.home_outlined,color: Colors.white,size: 40)
            ),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (builder) => edit_profile(
                   )));
            },
                icon: Icon(Icons.person_outline_outlined,color: Colors.white,size: 40)
            ),

          ],
        ),
      )
  );
}