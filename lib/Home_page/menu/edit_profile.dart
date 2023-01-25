import 'dart:io';
import 'dart:math';

import 'package:bookingo/Home_page/Home.dart';
import 'package:bookingo/Home_page/menu/user_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../sharedPreferences/sharedPreferences.dart';

import '../../component/ImageView.dart';
import '../../component/loading.dart';
import '../../../sharedPreferences/sharedPreferences.dart';

File? file;
var imgpicked;
var imgname;

class edit_profile extends StatefulWidget {

  const edit_profile({Key? key}) : super(key: key);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _buildappbar extends StatelessWidget {
var lang = sharedPreferences.getUser('lang');
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
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(29.0),
                bottomRight: Radius.circular(29.0))),
      ),
      title:  Padding(
        padding: EdgeInsets.only(right: 40, top: 20),
        child: Center(
          child: Text(
            lang == "en" ? 'Edit Profile':'اعدادات الحساب',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _edit_profileState extends State<edit_profile> {
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
          preferredSize: const Size.fromHeight(80.0),
          child: _buildappbar(),
        ),
        body: const SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }
}

class _buildBody extends StatefulWidget {

  const _buildBody({Key? key}) : super(key: key);


  @override
  __buildBodyState createState() => __buildBodyState();
}

class __buildBodyState extends State<_buildBody> {

  var lang = sharedPreferences.getUser('lang');

  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  TextEditingController _currentpasswordcontroller = TextEditingController();
  TextEditingController _newpasswordcontroller = TextEditingController();
  TextEditingController _repeatnewpasswordcontroller = TextEditingController();

  bool _isHidden1 = true;
  bool _isHidden2 = true;
  bool _isHidden3 = true;


  void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }
  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }
  void _togglePasswordView3() {
    setState(() {
      _isHidden3 = !_isHidden3;
    });
  }

  var firstName;
  var lastName;
  var phone;


  var dropdownvalue_gender = sharedPreferences.getUser('gender');
  var _gender = ["Select your Gender","Male","female"];

  String? dropdownvalue_governorate = sharedPreferences.getUser('city');
  var governorate = [
    'Select your City',
    'Cairo',
    'Alexandria',
    'Suez',
    'Aswan',
    'Bor saeed',
    'El shrkya',
    'matroh'
  ];

  var Gender_check = "";
  var Gov_check = "";

  var imgstate;
  var imgUrl= sharedPreferences.getUser('imgUrl');
  var textColor;

  void initState() {
    super.initState();
    setState(() {
      imgpicked = null;
      imgstate = lang == "en" ? 'Change Your Image':'تغيير الصوره';
      ;
      textColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    radius: 70.0,
                                    child: ClipOval(
                                      child: Image.network(
                                        "${sharedPreferences.getUser('imgUrl')}",
                                        width: 300,
                                        height: 300,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(img: sharedPreferences.getUser('imgurl'),)
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: textColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${imgstate}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    await _pickImage(context);
                                    if (imgpicked != null) {
                                      setState(() {
                                        imgstate = lang == "en" ? 'Image Inserted':'تم ادخال الصوره';
                                        textColor = Colors.lightGreen;
                                      });
                                      imgname = basename(file!.path);
                                      var random = Random().nextInt(100000000);
                                      imgname = "$random$imgname";
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: lang == "en" ? MainAxisAlignment.start:MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15, left: 10),
                              child:  Text(
                                  lang == "en" ? 'Edit Your Information :':' : تعديل المعلومات الخاصة بك',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: TextFormField(
                              initialValue: '${sharedPreferences.getUser('first_name')}',
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                labelText: lang == "en" ? 'First Name':'الاسم الاول',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor("#205072")),
                                hintText: lang == "en" ? 'Enter your first name':'ادخل اسمك الاول',
                                hintStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        HexColor("#205072").withOpacity(0.5)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor('#B3C3FF'),
                                  ),
                                ),
                              ),
                              onChanged: (text) {
                                firstName = text;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == "en" ? 'Please Enter Your First Name':'يرجى ادخال اسمك الاول';
                                }else if(firstName == null){
                                  firstName ="${sharedPreferences.getUser('first_name')}";}
                              }),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: TextFormField(
                              initialValue: '${sharedPreferences.getUser('last_name')}',
                              decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                            labelText: lang == "en" ? 'Last Name':'الاسم الاخير',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#205072")),
                            hintText: lang == "en" ? 'Enter your last name':'ادخل اسمك الثانى',
                            hintStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color:
                                HexColor("#205072").withOpacity(0.5)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: HexColor('#B3C3FF'),
                              ),
                            ),
                          ),
                              onChanged: (text) {
                                lastName = text;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == "en" ? 'Please Enter Your Last Name':'يرجى ادخال اسمك الثانى';
                                }else if(lastName == null){
                                  lastName ="${sharedPreferences.getUser('last_name')}";}
                              }),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: TextFormField(
                              initialValue: '${sharedPreferences.getUser('phone')}',
                              decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                            labelText: lang == "en" ? 'Phone Number':'رقم الهاتف',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#205072")),
                            hintText: lang == "en" ? 'Enter your Phone Number':'ادخل رقم هاتفك',
                            hintStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color:
                                HexColor("#205072").withOpacity(0.5)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: HexColor('#B3C3FF'),
                              ),
                            ),
                          ),
                              onChanged: (text) {
                                phone = text;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == "en" ? 'Please Enter Your Phone Number':'يرجى ادخال رقم هاتفك المحمول';
                                }else if(phone == null){
                                  phone ="${sharedPreferences.getUser('phone')}";}
                              }),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                 Text(
                                  lang == "en" ? 'Gender':'النوع',                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 25),
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 5, right: 5),
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: HexColor('#80858E'),
                                    ),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    value: dropdownvalue_gender,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down),
                                    items: _gender.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue_gender = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                        Gender_check != "" ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "$Gender_check",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ): Container(),
                        const SizedBox(height: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                 Text(
                                   lang == "en" ? 'Governorate':'المحافظه',                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 25),
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 5, right: 5),
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: HexColor('#80858E'),
                                    ),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    value: dropdownvalue_governorate,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down),
                                    items: governorate.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue_governorate = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                        Gov_check != "" ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "$Gov_check",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ): Container(),
                        const SizedBox(height: 40),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: HexColor("#1C81AB"),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            width: 220,
                            height: 55,
                            child: TextButton(
                              onPressed: () async {
                                UpdateData(context);
                              },
                              style:
                                  TextButton.styleFrom(primary: Colors.white),
                              child:  Text(
                                lang == "en" ? 'Save':'حفظ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const Divider(),
                Form(
                    key: _formkey2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: lang == "en" ? MainAxisAlignment.start:MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child:  Text(
                                lang == "en" ? 'Change Password :':' : تغيير الرقم السرى',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: TextFormField(
                                obscureText: _isHidden1,
                                controller: _currentpasswordcontroller,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  labelText: lang == "en" ? 'Current Password':'الرقم السرى الحالى',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: lang == "en" ? 'Enter your Current password':'ادخل الرقم السرى الحالى',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: const BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.black45),
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView1,
                                    child: Icon(
                                      Icons.visibility,
                                      color: HexColor("#496171")
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return lang == "en" ? 'Please Fill Current Password Input':'الرجاء إدخال كلمة المرور الحالية';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: TextFormField(
                                obscureText: _isHidden2,
                                controller: _newpasswordcontroller,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  labelText: lang == "en" ? 'New Password':'الرقم السرى الجديد',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: lang == "en" ? 'Enter your New password':'ادخل الرقم السرى الحالى',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: const BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.black45),
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView2,
                                    child: Icon(
                                      Icons.visibility,
                                      color: HexColor("#496171")
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return lang == "en" ? 'Please Fill New Password Input':'الرجاء إدخال كلمة المرور الجديده';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: TextFormField(
                                obscureText: _isHidden3,
                                controller: _repeatnewpasswordcontroller,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  labelText: lang == "en" ? 'Repeat Your Password':'اعاده الرقم السرى',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: lang == "en" ? 'Current Password':'اعد ادخال الرقم السرى الجديد',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: const BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.black45),
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView3,
                                    child: Icon(
                                      Icons.visibility,
                                      color: HexColor("#496171")
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return lang == "en" ? 'Please Repeat Your Password':'الرجاء إعادة كلمة المرور الخاصة بك';
                                  }else{
                                    return _newpasswordcontroller.text == value ? null : "Please Validate Your Entered Password";
                                  }
                                }),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: HexColor("#1C81AB"),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            width: 270,
                            height: 55,
                            child: TextButton(
                              onPressed: () async {
                                Updateassword(context);
                              },
                              style:
                                  TextButton.styleFrom(primary: Colors.white),
                              child:  Text(
                                lang == "en" ? 'Update Password':'تغيير الرقم السرى',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
        ),
      );
  }
  _Gender_check(){
    if(dropdownvalue_gender == "Select your Gender"){
      setState(() {
        Gender_check="Please Select your Gender";
      });
      return false;
    }else if(dropdownvalue_gender != "Select your Gender"){
      setState(() {
        Gender_check="";
      });
      return true;
    }
  }
  _Gov_check(){
    if(dropdownvalue_governorate == "Select your City"){
      setState(() {
        Gov_check="Please Select your City";
      });
      return false;
    }else if(dropdownvalue_governorate != "Select your City"){
      setState(() {
        Gov_check="";
      });
      return true;
    }
  }


  UpdateData(context) async {
    var x=_Gender_check();
    var y=_Gov_check();
    if (_formkey.currentState!.validate() && x && y) {
      try {
        var uid = FirebaseAuth.instance.currentUser!.uid;
        showLoading(context);
        if (imgpicked != null) {
          var refstorage = await FirebaseStorage.instance
              .ref("users_profile_images/$imgname");
          await refstorage.putFile(file!);
          var url = await refstorage.getDownloadURL();

          await FirebaseStorage.instance.refFromURL(imgUrl!).delete();

          var uid = FirebaseAuth.instance.currentUser!.uid;
          var userInfo =
              FirebaseFirestore.instance.collection('users').doc('$uid');
          userInfo.update({
            'first name': firstName,
            'last name': lastName,
            'phone': phone,
            'gender': dropdownvalue_gender,
            'city': dropdownvalue_governorate,
            'image url': url,
          });
          const snackBar = const SnackBar(
              content: Text(
                'Data Has been Updated Successfully',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home_page()),
          );
        }
        else {
          var uid = FirebaseAuth.instance.currentUser!.uid;
          var userInfo =
              FirebaseFirestore.instance.collection('users').doc('$uid');
          userInfo.update({
            'first name': firstName,
            'last name': lastName,
            'phone': phone,
            'gender': dropdownvalue_gender,
            'city': dropdownvalue_governorate,
          });
          const snackBar = const SnackBar(
              content: Text(
                'Data Has been Updated Successfully',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home_page()),
          );
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get()
            .then((snapshot) async {
          await sharedPreferences.setUser('first_name', snapshot.data.call()!['first name']);
          await sharedPreferences.setUser('last_name', snapshot.data.call()!['last name']);
          await sharedPreferences.setUser('phone', snapshot.data.call()!['phone']);
          await sharedPreferences.setUser('city', snapshot.data.call()!['city']);
          await sharedPreferences.setUser('imgUrl', snapshot.data.call()!['image url']);
          await sharedPreferences.setUser('email', snapshot.data.call()!['email']);
          await sharedPreferences.setUser('gender', snapshot.data.call()!['gender']);
          await sharedPreferences.setUser('userid', snapshot.data.call()!['userid']);
        });
      } catch (e) {}
    }
    const snackBar = const SnackBar(
        content: Text(
          'Data Has been Updated Successfully',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Updateassword(context) async {
    if (_formkey2.currentState!.validate()) {
      showLoading(context);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance.currentUser
          ?.updatePassword(_newpasswordcontroller.text)
          .then((_) {
        print("Successfully changed password");
        Navigator.of(context).pop();
        const snackBar = const SnackBar(
            content: Text(
              'Successfully changed password',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home_page()),
        );
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        Navigator.of(context).pop();
        var snackBar =  SnackBar(
            content: Text(
              "Password can't be changed, try later\nMaybe you should login again",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      });
    }
  }
}

_pickImage(context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please Choose Image',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  imgpicked =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (imgpicked != null) {
                    file = File(imgpicked.path);
                    Navigator.of(context).pop();

                    const snackBar = const SnackBar(
                        content: Text(
                          'Image Picked',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.lightGreen);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    const snackBar = const SnackBar(
                        content: Text(
                          'Image Not Picked',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.photo_outlined,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'From Gallery',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  imgpicked =
                      await ImagePicker().getImage(source: ImageSource.camera);
                  if (imgpicked != null) {
                    file = File(imgpicked.path);
                    Navigator.of(context).pop();
                    const snackBar = const SnackBar(
                        content: Text(
                          'Image Picked',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.lightGreen);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    const snackBar = const SnackBar(
                        content: Text(
                          'Image Not Picked',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'From Camera',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
