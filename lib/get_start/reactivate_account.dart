import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login.dart';

class reactivate_account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _buildappbar(),
      ),
      body: _buildbody(),
    );
  }
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      leading: IconButton(
          padding: EdgeInsets.only(top: 20.0),
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Colors.transparent,
      elevation: 10,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(29.0),
                bottomRight: Radius.circular(29.0))),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 20),
        child: new Text(
          "Reactivate Account",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
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
          SizedBox(height: 50),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Your account has been\nsuspended as you entered\nwrong password three\ntimes. ",
                textAlign: TextAlign.center,
                style:
                    new TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                Text(
                  'IF you want to reactive your.',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: HexColor("#1C81AB")),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#1C81AB")),
                      ),
                      Text(
                        " Click here !!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#FF0008")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
