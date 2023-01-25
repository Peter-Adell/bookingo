import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Home.dart';
import '../chatbot/chatbot.dart';
import 'edit_profile.dart';
import '../../sharedPreferences/sharedPreferences.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
            child:
            _buildbody(),
          ),
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
          sharedPreferences.getUser('lang') == 'en' ? "Contact Us" : "اتصل بنا",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
  var message;
  final _formkey = GlobalKey<FormState>();
  var lang =sharedPreferences.getUser('lang');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(lang == 'en' ? 'Contact Us' : 'معلومات الاتصال',
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang == 'en' ? 'Phone number' : 'رقم الهاتف',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('01257653284',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang == 'en' ? 'Another Phone number' : 'رقم هاتف اخر',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('03 8548985',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang == 'en' ? 'Email' : 'الايميل',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('El_Amlhospital@gmail.com',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang == 'en' ? 'For technical support' : 'للدعم الفني',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('support@gmail.com',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ),


        ],
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
