import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/loading.dart';
import '../../sharedPreferences/sharedPreferences.dart';

class chatbot extends StatefulWidget {
  const chatbot({Key? key}) : super(key: key);

  @override
  State<chatbot> createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#EBEBEB'),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: _buildappbar(),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: _body()
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
          "Chat",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _body extends StatefulWidget {
  const _body({Key? key}) : super(key: key);

  @override
  State<_body> createState() => _bodyState();
}

class _bodyState extends State<_body> {
  bool isStart = true;
  bool isStart2 = true;
  bool isEnglish = false ;
  bool isArabic = false;

  bool isClinic = false;
  bool isLaboratory = false;
  bool isScan = false;
  bool isPhysiotherapy  = false;
  bool isDetails  = false;
  bool isInquiries  = false;
  bool isOther = false;

  bool isClinic1 = false;
  bool isClinic2 = false;
  bool isClinic3 = false;

  bool isLaboratory1 = false;
  bool isLaboratory2 = false;
  bool isLaboratory3 = false;

  bool isScan1 = false;
  bool isScan2 = false;
  bool isScan3 = false;

  bool isPhysiotherapy1  = false;
  bool isPhysiotherapy2  = false;

  bool isDetails1  = false;
  bool isDetails2  = false;
  bool isDetails3  = false;

  bool isInquiries1  = false;





  bool flg1 = true;
  bool flg2 = true;
  bool flg3 = true;
  bool flg4 = true;
  bool flg5 = true;
  bool flg6 = true;




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25.0,
                child: ClipOval(
                  child: Image.asset(
                    "assets/icons/bot.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  constraints: BoxConstraints(
                      maxWidth: 300
                  ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius:
                    BorderRadius.only(
                        bottomLeft: Radius
                            .circular(15),
                        bottomRight:
                        Radius
                            .circular(
                            15),
                        topRight: Radius
                            .circular(
                            15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white),
                child: isStart ? FutureBuilder(
                    future: Future.delayed(Duration(milliseconds: 1500)),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                       return Container(
                         constraints: new BoxConstraints(
                           maxWidth: 250,
                         ),
                         child: Column(
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   'Hello, ${sharedPreferences.getUser('first_name')} ${sharedPreferences.getUser('last_name')}',
                                   style: TextStyle(fontSize: 16),),
                                 SizedBox(height: 5,),
                                 Text(
                                   'Please Select a language to proceed with',
                                   style: TextStyle(fontSize: 16),),
                               ],
                             ),
                             SizedBox(height: 20),
                             Container(
                               margin: EdgeInsets.only(bottom: 5),
                               decoration: BoxDecoration(
                                 color: HexColor("#1C81AB"),
                                 borderRadius: BorderRadius.circular(21),
                               ),
                               width: 200,
                               height: 40,
                               child: TextButton(
                                 onPressed: ()  {
                                   setState(() {
                                     isEnglish = true;
                                     isArabic = false;
                                     isStart = false;
                                   });
                                 },
                                 style: TextButton.styleFrom(primary: Colors.white),
                                 child: Text(
                                   'English',
                                   style:
                                   TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ),
                             Container(
                               margin: EdgeInsets.only(bottom: 5),
                               decoration: BoxDecoration(
                                 color: HexColor("#1C81AB"),
                                 borderRadius: BorderRadius.circular(21),
                               ),
                               width: 200,
                               height: 40,
                               child: TextButton(
                                 onPressed: ()  {
                                   setState(() {
                                     isArabic = true;
                                     isEnglish = false;
                                     isStart = false;
                                   });
                                 },
                                 style: TextButton.styleFrom(primary: Colors.white),
                                 child: Text(
                                   'العربيه',
                                   style:
                                   TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ),

                           ],
                         ),
                       );
                      }
                      return Container(
                        width: 80,
                        height: 10,
                        margin: EdgeInsets.symmetric(
                            vertical: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration:
                              BoxDecoration(
                                  shape: BoxShape
                                      .circle,
                                  color: Colors
                                      .black
                                      .withOpacity(
                                      .2)),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 10,
                              height: 10,
                              decoration:
                              BoxDecoration(
                                  shape: BoxShape
                                      .circle,
                                  color: Colors
                                      .black
                                      .withOpacity(
                                      .2)),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 10,
                              height: 10,
                              decoration:
                              BoxDecoration(
                                  shape: BoxShape
                                      .circle,
                                  color: Colors
                                      .black
                                      .withOpacity(
                                      .2)),
                            ),
                          ],
                        ),
                      );
                    })
                    :
                Column(
                  children: [
                    Text(
                      'Hello, ${sharedPreferences.getUser('first_name')} ${sharedPreferences.getUser('last_name')}\n'
                          'Please Select a language to proceed with',
                      style: TextStyle(),),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: HexColor("#1C81AB"),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      width: 200,
                      height: 40,
                      child: TextButton(
                        onPressed: ()  {
                         if(!isArabic && !isEnglish){
                           setState(() {
                             isEnglish = true;
                           });
                         }
                        },
                        style: TextButton.styleFrom(primary: Colors.white),
                        child: Text(
                          'English',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: HexColor("#1C81AB"),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      width: 200,
                      height: 40,
                      child: TextButton(
                        onPressed: ()  {
                          if(!isArabic && !isEnglish){
                            setState(() {
                              isArabic = true;
                            });
                          }
                        },
                        style: TextButton.styleFrom(primary: Colors.white),
                        child: Text(
                          'العربيه',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  ],
                )
              ),
            ],
          ),
          isArabic  ?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius:
                      BorderRadius.only(
                          bottomLeft: Radius
                              .circular(15),
                          topLeft:
                          Radius
                              .circular(
                              15),
                          topRight: Radius
                              .circular(
                              15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color:HexColor('#A3B9C2')
                  ),
                  child:
                  Text(
                    'العربيه',
                    style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ],
          ):
          isEnglish  ?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius:
                    BorderRadius.only(
                        bottomLeft: Radius
                            .circular(15),
                        topLeft:
                        Radius
                            .circular(
                            15),
                        topRight: Radius
                            .circular(
                            15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color:HexColor('#A3B9C2')
                ),
                child:
                Text(
                  'English',
                  style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ],
          )
          :Container(),
   //////////////////////////////////
          isArabic || isEnglish ?
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25.0,
                child: ClipOval(
                  child: Image.asset(
                    "assets/icons/bot.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(

                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius:
                      BorderRadius.only(
                          bottomLeft: Radius
                              .circular(15),
                          bottomRight:
                          Radius
                              .circular(
                              15),
                          topRight: Radius
                              .circular(
                              15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white),
                  child: isStart2 ?
                  FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: 1500)),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){

                          return isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Bookingo اهلا بيك فى ',
                                    style: TextStyle(),),
                                  Text(
                                    'عايز تسأل عن ايه؟',
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isClinic = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'العيادات',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), //Clinics
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isLaboratory = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'التحاليل',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),//laboratory
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isScan = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'الأشعة',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // scan center
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isPhysiotherapy = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'العلاج الطبيعي',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // Physiotherapy
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isDetails = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'تفاصيل عن المستشفى',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // details about the hospital
                              Container(
                                width: 210,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isInquiries = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'استعلام عن شركات تأمين',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // inquiries about insurance companies
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isOther = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'آخر',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // other


                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Welcome to bookinGo',
                                    style: TextStyle(),),
                                  Text(
                                    'What do you want to ask?',
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isClinic = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Clinics',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ), //Clinics
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isLaboratory = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'laboratory',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),//laboratory
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isScan = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'scan center',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ), // scan center
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isPhysiotherapy = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Physiotherapy',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ), // Physiotherapy
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isDetails = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'details about the hospital',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ), // details about the hospital
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isInquiries = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'inquiries about\ninsurance companies',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ), // inquiries about insurance companies
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isClinic && !isLaboratory
                                        && !isScan
                                        && !isPhysiotherapy
                                        && !isDetails
                                        && !isInquiries
                                        && !isOther){
                                      setState(() {
                                        isOther = true;
                                        isStart2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'other',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ), // other


                            ],
                          );
                        }
                        return Container(
                          width: 80,
                          height: 10,
                          margin: EdgeInsets.symmetric(
                              vertical: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration:
                                BoxDecoration(
                                    shape: BoxShape
                                        .circle,
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .2)),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 10,
                                height: 10,
                                decoration:
                                BoxDecoration(
                                    shape: BoxShape
                                        .circle,
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .2)),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 10,
                                height: 10,
                                decoration:
                                BoxDecoration(
                                    shape: BoxShape
                                        .circle,
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .2)),
                              ),
                            ],
                          ),
                        );
                      })
                      :
                  isArabic ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Bookingo اهلا بيك فى ',
                            style: TextStyle(),),
                          Text(
                            'عايز تسأل عن ايه؟',
                            style: TextStyle(),),
                        ],),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isClinic = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'العيادات',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ), //Clinics
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isLaboratory = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'التحاليل',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),//laboratory
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isScan = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'الأشعة',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ), // scan center
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isPhysiotherapy = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'العلاج الطبيعي',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ), // Physiotherapy
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isDetails = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'تفاصيل عن المستشفى',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ), // details about the hospital
                      Container(
                        width: 210,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isInquiries = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'استعلام عن شركات تأمين',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ), // inquiries about insurance companies
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isOther = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'آخر',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ), // other


                    ],
                  )
                      :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome to bookinGo',
                            style: TextStyle(),),
                          Text(
                            'What do you want to ask?',
                            style: TextStyle(),),
                        ],),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isClinic = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'Clinics',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), //Clinics
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isLaboratory = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'laboratory',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),//laboratory
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isScan = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'scan center',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), // scan center
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isPhysiotherapy = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'Physiotherapy',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), // Physiotherapy
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isDetails = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'details about the hospital',
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), // details about the hospital
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isInquiries = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'inquiries about\ninsurance companies',
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), // inquiries about insurance companies
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: HexColor("#1C81AB"),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 210,
                        child: TextButton(
                          onPressed: ()  {
                            if(!isClinic && !isLaboratory
                                && !isScan
                                && !isPhysiotherapy
                                && !isDetails
                                && !isInquiries
                                && !isOther){
                              setState(() {
                                isOther = true;
                                isStart2 = false;
                              });
                            }
                          },
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'other',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), // other


                    ],
                  )
              ),
            ],
          ):
          Container(),
  ///////////////////////////////////
          isClinic ?
          Container(
            child:
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          borderRadius:
                          BorderRadius.only(
                              bottomLeft: Radius
                                  .circular(15),
                              topLeft:
                              Radius
                                  .circular(
                                  15),
                              topRight: Radius
                                  .circular(
                                  15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color:HexColor('#A3B9C2')
                      ),
                      child:
                      isArabic ? Text(
                        'العيادات',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                      ):Text(
                        'Clinics',
                        style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25.0,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/icons/bot.png",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                bottomRight:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white),
                        child: flg1 ?
                        FutureBuilder(
                            future: Future.delayed(Duration(milliseconds: 1500)),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){
                                return  isArabic ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: const [
                                        Text(
                                          'ما هو استفسارك عن العيادات؟',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(),),
                                      ],),
                                    SizedBox(height: 20),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: HexColor("#1C81AB"),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      width: 210,
                                      child: TextButton(
                                        onPressed: ()  {
                                          if(!isClinic1 && !isClinic2 && !isClinic3){
                                            setState(() {
                                              isClinic1 = true;
                                              flg1 = false;
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          'التخصصات المتاحة',
                                          textDirection: TextDirection.rtl,
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: HexColor("#1C81AB"),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      width: 210,
                                      child: TextButton(
                                        onPressed: ()  {
                                          if(!isClinic1 && !isClinic2 && !isClinic3){
                                            setState(() {
                                              isClinic2 = true;
                                              flg1 = false;
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          'مواعيد العيادات ',
                                          textDirection: TextDirection.rtl,
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: HexColor("#1C81AB"),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      width: 210,
                                      child: TextButton(
                                        onPressed: ()  {
                                          if(!isClinic1 && !isClinic2 && !isClinic3){
                                            setState(() {
                                              isClinic3 = true;
                                              flg1 = false;
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          'تغيير حجز الدكتور الى دكتور آخر',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ), // other
                                  ],
                                )
                                    :Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: const [
                                        Text(
                                          'What is your inquiry about clinics?',
                                          style: TextStyle(),),

                                      ],),
                                    SizedBox(height: 20),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: HexColor("#1C81AB"),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      width: 210,
                                      child: TextButton(
                                        onPressed: ()  {
                                          if(!isClinic1 && !isClinic2 && !isClinic3){
                                            setState(() {
                                              isClinic1 = true;
                                              flg1 = false;
                                            });
                                          }

                                        },
                                        style: TextButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          'Available Specialties',
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: HexColor("#1C81AB"),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      width: 210,
                                      child: TextButton(
                                        onPressed: ()  {
                                          if(!isClinic1 && !isClinic2 && !isClinic3){
                                            setState(() {
                                              isClinic2 = true;
                                              flg1 = false;
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          'Clinic appointments',
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: HexColor("#1C81AB"),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      width: 210,
                                      child: TextButton(
                                        onPressed: ()  {
                                          if(!isClinic1 && !isClinic2 && !isClinic3){
                                            setState(() {
                                              isClinic3 = true;
                                              flg1 = false;
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          'change the doctor’s reservation',
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                width: 80,
                                height: 10,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration:
                                      BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              .2)),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration:
                                      BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              .2)),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration:
                                      BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              .2)),
                                    ),
                                  ],
                                ),
                              );
                            })
                            :
                        isArabic ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  'ما هو استفسارك عن العيادات؟',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(),),
                              ],),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 210,
                              child: TextButton(
                                onPressed: ()  {
                                  if(!isClinic1 && !isClinic2 && !isClinic3){
                                    setState(() {
                                      isClinic1 = true;
                                      flg1 = false;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  'التخصصات المتاحة',
                                  textDirection: TextDirection.rtl,
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 210,
                              child: TextButton(
                                onPressed: ()  {
                                  if(!isClinic1 && !isClinic2 && !isClinic3){
                                    setState(() {
                                      isClinic2 = true;
                                      flg1 = false;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  'مواعيد العيادات ',
                                  textDirection: TextDirection.rtl,
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 210,
                              child: TextButton(
                                onPressed: ()  {
                                  if(!isClinic1 && !isClinic2 && !isClinic3){
                                    setState(() {
                                      isClinic3 = true;
                                      flg1 = false;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  'تغيير حجز الدكتور الى دكتور آخر',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ), // other
                          ],
                        )
                            :Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  'What is your inquiry about clinics?',
                                  style: TextStyle(),),

                              ],),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 210,
                              child: TextButton(
                                onPressed: ()  {
                                  if(!isClinic1 && !isClinic2 && !isClinic3){
                                    setState(() {
                                      isClinic1 = true;
                                      flg1 = false;
                                    });
                                  }

                                },
                                style: TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  'Available Specialties',
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 210,
                              child: TextButton(
                                onPressed: ()  {
                                  if(!isClinic1 && !isClinic2 && !isClinic3){
                                    setState(() {
                                      isClinic2 = true;
                                      flg1 = false;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  'Clinic appointments',
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: HexColor("#1C81AB"),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 210,
                              child: TextButton(
                                onPressed: ()  {
                                  if(!isClinic1 && !isClinic2 && !isClinic3){
                                    setState(() {
                                      isClinic3 = true;
                                      flg1 = false;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(primary: Colors.white),
                                child: Text(
                                  'change the doctor’s reservation',
                                  textAlign: TextAlign.center,
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            )
          ):
          isLaboratory ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'التحاليل',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'laboratory',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: flg2 ?
                          FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 1500)),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  return  isArabic ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'ما هو استفسارك عن التحاليل؟',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                              setState(() {
                                                isLaboratory1 = true;
                                                flg2 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مواعيد التحاليل',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                              setState(() {
                                                isLaboratory2 = true;
                                                flg2 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مكان التحاليل',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                              setState(() {
                                                isLaboratory3 = true;
                                                flg2 = false;
                                              });
                                            }                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'التحاليل التي تطلب صيام مسبق',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ), // other
                                    ],
                                  )
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'What is your inquiry about laboratory?',
                                            style: TextStyle(),),

                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                              setState(() {
                                                isLaboratory1 = true;
                                                flg2 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'laboratory working hours',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                              setState(() {
                                                isLaboratory2 = true;
                                                flg2 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'The location of the laboratory',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                              setState(() {
                                                isLaboratory3 = true;
                                                flg2 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Tests that require pre-fasting ',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Container(
                                  width: 80,
                                  height: 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              :
                          isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'ما هو استفسارك عن التحاليل؟',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                      setState(() {
                                        isLaboratory1 = true;
                                        flg2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مواعيد التحاليل',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                      setState(() {
                                        isLaboratory2 = true;
                                        flg2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مكان التحاليل',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                      setState(() {
                                        isLaboratory3 = true;
                                        flg2 = false;
                                      });
                                    }                                          },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'التحاليل التي تطلب صيام مسبق',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // other
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'What is your inquiry about laboratory?',
                                    style: TextStyle(),),

                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                      setState(() {
                                        isLaboratory1 = true;
                                        flg2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'laboratory working hours',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                      setState(() {
                                        isLaboratory2 = true;
                                        flg2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'The location of the laboratory',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isLaboratory1 && !isLaboratory2 && !isLaboratory3){
                                      setState(() {
                                        isLaboratory3 = true;
                                        flg2 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Tests that require pre-fasting ',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isScan ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'الأشعه',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'scan center',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: flg3 ?
                          FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 1500)),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  return  isArabic ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'ما هو استفسارك عن الأشعه؟',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isScan1 && !isScan2 && !isScan3){
                                              setState(() {
                                                isScan1 = true;
                                                flg3 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مواعيد الأشعة',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isScan1 && !isScan2 && !isScan3){
                                              setState(() {
                                                isScan2 = true;
                                                flg3 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مكان الأشعة',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isScan1 && !isScan2 && !isScan3){
                                              setState(() {
                                                isScan3 = true;
                                                flg3 = false;
                                              });
                                            }
                                            },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'أنواع الأشعة',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ), // other
                                    ],
                                  )
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'What is your inquiry about scan center?',
                                            style: TextStyle(),),

                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isScan1 && !isScan2 && !isScan3){
                                              setState(() {
                                                isScan1 = true;
                                                flg3 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'scan center appointments',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isScan1 && !isScan2 && !isScan3){
                                              setState(() {
                                                isScan2 = true;
                                                flg3 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'scan center location',
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isScan1 && !isScan2 && !isScan3){
                                              setState(() {
                                                isScan3 = true;
                                                flg3 = false;
                                              });
                                            }                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Types',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Container(
                                  width: 80,
                                  height: 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              :
                          isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'ما هو استفسارك عن الأشعه؟',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isScan1 && !isScan2 && !isScan3){
                                      setState(() {
                                        isScan1 = true;
                                        flg3 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مواعيد الأشعة',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isScan1 && !isScan2 && !isScan3){
                                      setState(() {
                                        isScan2 = true;
                                        flg3 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مكان الأشعة',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isScan1 && !isScan2 && !isScan3){
                                      setState(() {
                                        isScan3 = true;
                                        flg3 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'أنواع الأشعة',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), // other
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'What is your inquiry about scan center?',
                                    style: TextStyle(),),

                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isScan1 && !isScan2 && !isScan3){
                                      setState(() {
                                        isScan1 = true;
                                        flg3 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'scan center appointments',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isScan1 && !isScan2 && !isScan3){
                                      setState(() {
                                        isScan2 = true;
                                        flg3 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'scan center location',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isScan1 && !isScan2 && !isScan3){
                                      setState(() {
                                        isScan3 = true;
                                        flg3 = false;
                                      });
                                    }                                          },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Types',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isPhysiotherapy ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'العلاج الطبيعي',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Physiotherapy',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: flg4 ?
                          FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 1500)),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  return  isArabic ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'ما هو استفسارك عن العلاج الطبيعى؟',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                              setState(() {
                                                isPhysiotherapy1 = true;
                                                flg4 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مدة جلسة العلاج الطبيعي',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                              setState(() {
                                                isPhysiotherapy2 = true;
                                                flg4 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مواعيد العلاج الطبيعي',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'What is your inquiry about Physiotherapy?',
                                            style: TextStyle(),),

                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                              setState(() {
                                                isPhysiotherapy1 = true;
                                                flg4 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Duration of the physiotherapy session ',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                              setState(() {
                                                isPhysiotherapy2 = true;
                                                flg4 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Physiotherapy appointments',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                    ],
                                  );
                                }
                                return Container(
                                  width: 80,
                                  height: 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              :
                          isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'ما هو استفسارك عن العلاج الطبيعى؟',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                      setState(() {
                                        isPhysiotherapy1 = true;
                                        flg4 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مدة جلسة العلاج الطبيعي',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                      setState(() {
                                        isPhysiotherapy2 = true;
                                        flg4 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مواعيد العلاج الطبيعي',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'What is your inquiry about Physiotherapy?',
                                    style: TextStyle(),),

                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                      setState(() {
                                        isPhysiotherapy1 = true;
                                        flg4 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Duration of the physiotherapy session ',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isPhysiotherapy1 && !isPhysiotherapy2){
                                      setState(() {
                                        isPhysiotherapy2 = true;
                                        flg4 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Physiotherapy appointments',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),

                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isDetails ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'تفاصيل عن المستشفى',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Details about the hospital',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: flg5 ?
                          FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 1500)),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  return  isArabic ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'اختر احد الاستفسارات عن المستشفى',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isDetails1 && !isDetails2 && !isDetails3){
                                              setState(() {
                                                isDetails1 = true;
                                                flg5 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'العنوان',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isDetails1 && !isDetails2 && !isDetails3){
                                              setState(() {
                                                isDetails2 = true;
                                                flg5 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'أرقام التواصل',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isDetails1 && !isDetails2 && !isDetails3){
                                              setState(() {
                                                isDetails3 = true;
                                                flg5 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'مواعيد المستشفى',
                                            textDirection: TextDirection.rtl,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'Choose one of the inquiries about the hospital!',
                                            style: TextStyle(),),

                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isDetails1 && !isDetails2 && !isDetails3){
                                              setState(() {
                                                isDetails1 = true;
                                                flg5 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Address',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isDetails1 && !isDetails2 && !isDetails3){
                                              setState(() {
                                                isDetails2 = true;
                                                flg5 = false;
                                              });
                                            }                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Contact numbers',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isDetails1 && !isDetails2 && !isDetails3){
                                              setState(() {
                                                isDetails3 = true;
                                                flg5 = false;
                                              });
                                            }                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Hospital appointments',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                    ],
                                  );
                                }
                                return Container(
                                  width: 80,
                                  height: 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              :
                          isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'اختر احد الاستفسارات عن المستشفى',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isDetails1 && !isDetails2 && !isDetails3){
                                      setState(() {
                                        isDetails1 = true;
                                        flg5 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'العنوان',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isDetails1 && !isDetails2 && !isDetails3){
                                      setState(() {
                                        isDetails2 = true;
                                        flg5 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'أرقام التواصل',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isDetails1 && !isDetails2 && !isDetails3){
                                      setState(() {
                                        isDetails3 = true;
                                        flg5 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'مواعيد المستشفى',
                                    textDirection: TextDirection.rtl,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Choose one of the inquiries about the hospital!',
                                    style: TextStyle(),),

                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isDetails1 && !isDetails2 && !isDetails3){
                                      setState(() {
                                        isDetails1 = true;
                                        flg5 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Address',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isDetails1 && !isDetails2 && !isDetails3){
                                      setState(() {
                                        isDetails2 = true;
                                        flg5 = false;
                                      });
                                    }                                          },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Contact numbers',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isDetails1 && !isDetails2 && !isDetails3){
                                      setState(() {
                                        isDetails3 = true;
                                        flg5 = false;
                                      });
                                    }                                          },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Hospital appointments',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),

                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isInquiries ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'استعلام عن شركات تأمين',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Inquiry about insurance companies',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: flg6 ?
                          FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 1500)),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  return  isArabic ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'استعلام عن شركات تأمين',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isInquiries1){
                                              setState(() {
                                                isInquiries1 = true;
                                                flg6 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'هل يوجد تعاقد مع شركات تأمين؟',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'Inquiry about insurance companies',
                                            style: TextStyle(),),

                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            if(!isInquiries1){
                                              setState(() {
                                                isInquiries1 = true;
                                                flg6 = false;
                                              });
                                            }
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'Is there a contract with insurance companies?',
                                            textAlign: TextAlign.center,
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                    ],
                                  );
                                }
                                return Container(
                                  width: 80,
                                  height: 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              :
                          isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'استعلام عن شركات تأمين',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isInquiries1){
                                      setState(() {
                                        isInquiries1 = true;
                                        flg6 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'هل يوجد تعاقد مع شركات تأمين؟',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Inquiry about insurance companies',
                                    style: TextStyle(),),

                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    if(!isInquiries1){
                                      setState(() {
                                        isInquiries1 = true;
                                        flg6 = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'Is there a contract with insurance companies?',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),

                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isOther ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'آخر',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Other',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child:
                          FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 1500)),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  return  isArabic ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'للتواصل مع الدعم الفنى support@gmail.com',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                          SizedBox(height: 5,),
                                          Text(
                                            'للاستفسار عن الحجوزات او المستشفى او عزل الكورونا\n'
                                                '01257653284\n03 8548985\n'
                                                'او على الايميل\n'
                                                'El_Amlhospital@gmail.com',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'ابدا من جديد',
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'To contact technical support\nsupport@gmail.com',
                                            style: TextStyle(),),
                                          SizedBox(height: 5,),
                                          Text(
                                            'To inquire about reservations, hospital or corona isolation\n'
                                          '01257653284\n03 8548985\n'
                                          'or by email\n'
                                          'El_Amlhospital@gmail.com',
                                            style: TextStyle(),),
                                        ],),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: HexColor("#1C81AB"),
                                          borderRadius: BorderRadius.circular(21),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: 210,
                                        child: TextButton(
                                          onPressed: ()  {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                          },
                                          style: TextButton.styleFrom(primary: Colors.white),
                                          child: Text(
                                            'start again',
                                            style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                    ],
                                  );
                                }
                                return Container(
                                  width: 80,
                                  height: 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .black
                                                .withOpacity(
                                                .2)),
                                      ),
                                    ],
                                  ),
                                );
                              })

                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
  ///////////////////////////////////
          isClinic1 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'التخصصات المتاحه',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Available Specialties',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'التخصصات المتاحه',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'باطنة, جلدية, أنف و أذن و حنجرة, أسنان, قلب,أمراض صدر, عظام, أطفال, نساء و توليد,جراحة, رمد, أورام, مخ و أعصاب',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Available Specialties',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                   'Internal Medicine, Dermatology, otolaryngology, Dental, Heart, pulmonologist, Orthopedics, Pediatrics, Obstetrics and Gynecology, Surgery, Ophthalmology',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isClinic2 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مواعيد العيادات',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Available Specialties',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مواعيد العيادات',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'متاح طوال أيام الاسبوع من 8 صباحا الى 11 مساءا',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Clinic appointments',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Available all days of the week from 8 am to 11 pm',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isClinic3 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'تغيير حجز الدكتور الى دكتور آخر',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'change the doctor’s reservation',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'اذا أردت تغيير حجز الدكتور الى دكتور آخر',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                      Text(
                                    'من فضلك قم بألغاء الحجز ثم قم بحجز الدكتور المراد الحجز معه باتباع الخطوات من البداية',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'If you want to change the doctor’s reservation to another doctor',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                   Text(
                                    'Please cancel the reservation and then book your appointment with the other doctor.',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
///////////////////////////////////
          isLaboratory1 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مواعيد التحاليل',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'laboratory working hours',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مواعيد التحاليل',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'التحاليل متاحة من 10 صباحا حتى 10 مساءا',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'laboratory working hours',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'laboratory works  from 10 am to 10 pm',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isLaboratory2 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مكان التحاليل ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'The location of the laboratory ',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مكان التحاليل ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'قسم التحاليل يوجد بالدور الأول',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'The location of the laboratory',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'The laboratory department is located on the first floor',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isLaboratory3 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'التحاليل التي تطلب صيام مسبق',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Tests that require pre-fasting',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'التحاليل التي تطلب صيام مسبق',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'تحليل السكرالصائم , تحليل الدهون الشامل, تحليل الحديدفي الدمو تحليل فيتامين B12 تحليل الغدة الدرقية, تحليل البول, تحليل سرعة الترسيب, تحليل بول الحملز',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Tests that require pre-fasting',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Fasting glucose test, complete lipid test, iron blood test, vitamin B12 test, thyroid test, urinalysis, erythrocyte sedimentation rate, pregnancy urine test',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
///////////////////////////////////
          isScan1 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مواعيد الأشعه',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'scan center appointments',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مواعيد الأشعه',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'الأشعة متاحة من 10 صباحا حتى 10 مساءا',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'scan center appointments',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'available from 10 am to 10 pm',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isScan2 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مكان الأشعه ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'scan center location',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مكان الأشعه ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'قسم الأشعة يوجد بالدور الثاني',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'scan center location',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'The  scan center is located on the second floor',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isScan3 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'أنواع الأشعة',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Types',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'أنواع الأشعة',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'جميع أنواع الأشعة متاحة',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Types',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'All types are available',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
////////////////////////////////////
          isPhysiotherapy1 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مدة جلسة العلاج الطبيعي ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Duration of the physiotherapy session',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مدة جلسة العلاج الطبيعي ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'مدة الجلسة نصف ساعة',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Duration of the physiotherapy session ',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Duration of the session is half an hour',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isPhysiotherapy2 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مواعيد العلاج الطبيعي',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Physiotherapy appointments',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مواعيد العلاج الطبيعي',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'متاح طوال أيام الاسبوع من 10 صباحا الى 10 مساءا',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Physiotherapy appointments',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Available all days of the week from 10 am to 10 pm',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
/////////////////////////////////////
          isDetails1 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'العنوان',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Address',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:  [
                                  Text(
                                    'العنوان',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'شعراوى، سانستيفانو، الرمل، الاسكندرية',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  InkWell(
                                    onTap: () async {
                                      var url = Uri.parse('https://www.google.com/maps/place/43-427+Shaarawy,+San+Stefano,+El+Raml+2,+Alexandria+Governorate+5452056/@31.2504475,29.9705113,18z/data=!4m2!3m1!1s0x14f5c5338ee13105:0x24eb6a9651a0199d');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      'Location',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 16, color: Colors.blue ,  decoration: TextDecoration.underline,
                                      ),),
                                  ),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    'Address',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Shaarawy,Sanstefano, El Raml, Alex',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  InkWell(
                                    onTap: () async {
                                      showLoading(context);
                                      var url = Uri.parse('https://www.google.com/maps/place/43-427+Shaarawy,+San+Stefano,+El+Raml+2,+Alexandria+Governorate+5452056/@31.2504475,29.9705113,18z/data=!4m2!3m1!1s0x14f5c5338ee13105:0x24eb6a9651a0199d');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      'Location',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 16, color: Colors.blue ,  decoration: TextDecoration.underline,
                                      ),),
                                  ),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isDetails2 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'أرقام التواصل',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Contact numbers',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    ':ارقام المستشفى',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    '01257653284\n03 8548985',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Hospital numbers: ',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    '01257653284\n03 8548985',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          isDetails3 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'مواعيد المستشفى',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Hospital appointments',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مواعيد المستشفى',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    '- مواعيد العيادات, التحاليل_ الأشعة_ العلاج الطبيعي من 8 صباحا حتى 11 مساءا \n- مواعيد الطوارئ 24 ساعة',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Hospital appointments',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    '- Clinic appointments, laboratory _ scan center_ physiotherapy from 8 am to 11 pm\n- 24hour emergency',
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
          ////////////////////////////////////
          isInquiries1 ?
          Container(
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: new BoxConstraints(
                          maxWidth: 250,
                        ),
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                            BorderRadius.only(
                                bottomLeft: Radius
                                    .circular(15),
                                topLeft:
                                Radius
                                    .circular(
                                    15),
                                topRight: Radius
                                    .circular(
                                    15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color:HexColor('#A3B9C2')
                        ),
                        child:
                        isArabic ? Text(
                          'هل يوجد تعاقد مع شركات تأمين؟',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ):Text(
                          'Is there a contract with insurance companies?',
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/bot.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          constraints: new BoxConstraints(
                            maxWidth: 250,
                          ),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft: Radius
                                      .circular(15),
                                  bottomRight:
                                  Radius
                                      .circular(
                                      15),
                                  topRight: Radius
                                      .circular(
                                      15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: isArabic ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'هل يوجد تعاقد مع شركات تأمين؟',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),                                  Text(
                                    'نعم, الشركات المتعاقد معها هي :(Prime Health, Seif Health Care, Active, Inaya ) اذا أردت الحجز من خلال شركة تأمين من فضلك قم باختيار الدفع من خلال المستشفى',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'ابدا من جديد',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Is there a contract with insurance companies?',
                                    style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text(
                                    "Yes, the contracting companies are :(Prime health, Seif Health Care, Inaya, Active ) If you want to book through an insurance company, please choose to pay offline.",
                                    style: TextStyle(fontSize: 16),),
                                ],),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: HexColor("#1C81AB"),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 210,
                                child: TextButton(
                                  onPressed: ()  {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>chatbot()));
                                  },
                                  style: TextButton.styleFrom(primary: Colors.white),
                                  child: Text(
                                    'start again',
                                    style:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
          ):
          Container(),
        ],
      ),
    );
  }
}
