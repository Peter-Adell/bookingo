import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Home.dart';
import '../chatbot/chatbot.dart';
import 'edit_profile.dart';



class NotiFicationPage extends StatefulWidget {
  const NotiFicationPage({Key? key}) : super(key: key);

  @override
  State<NotiFicationPage> createState() => _NotiFicationPageState();
}

class _NotiFicationPageState extends State<NotiFicationPage> {
  var uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference Noti =  FirebaseFirestore.instance.collection('users');

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
            child:Container(
              padding: EdgeInsets.all(15),
              child:  FutureBuilder(
                  future: Noti.doc(uid).collection('notifications')
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, i) {
                            return List(snapshot.data.docs[i]['msg']);
                          });
                    }

                    return Center(child: CircularProgressIndicator());
                  }),
            )
          ),
          bottomNavigationBar: BottomNavigationBar(context),
        )
    );
  }
  Widget List(msg){
    return Container(
      margin: EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
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
        child: Row(
          children: [
            Icon(Icons.notifications_none_outlined),
            SizedBox(width: 5),
            Expanded(child: Text('Content : $msg')),
          ],
        ),
      ),
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
          "Notifications",
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
                  Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
