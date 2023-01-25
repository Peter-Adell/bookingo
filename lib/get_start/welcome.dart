
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login.dart';



class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _buildappbar(),
      ),
      body:
      _buildbody(),
    );
  }
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 10,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: HexColor('#1C81AB'),
            borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(29.0),
                bottomRight: Radius.circular(29.0))),
      ),
      title:
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: new Text(
                "Welcome To Booking Go",
                style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
    ),
          ),);
  }
}


class _buildbody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(top:20),
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
          ),
          SizedBox(height: 30),

          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Text(
                        'Healing Hand',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#1C81AB")),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Caring Hearts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#1C81AB")),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HexColor('#1C81AB'),
              borderRadius: BorderRadius.circular(21),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(5, 10), // changes position of shadow
                ),
              ],
            ),
            width: 200,
            height: 55,
            child: new TextButton(
                style:
                TextButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => login(),
                      ));
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(height: 50),
          Image(
            image: AssetImage('assets/footer.png'),
          ),
        ],
      ),
    );
  }
}
