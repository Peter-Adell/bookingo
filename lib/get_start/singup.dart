import 'dart:io';
import 'dart:math';

import 'package:bookingo/Home_page/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../component/loading.dart';
import 'login.dart';

File file = file;
var imgpicked;
var imgname;
bool isChecked = false;

class singup extends StatefulWidget {
  const singup({Key? key}) : super(key: key);

  @override
  State<singup> createState() => _singupState();
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          padding: EdgeInsets.only(top: 20.0),
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () =>  Navigator.pop(context)
      ),

      backgroundColor: Colors.transparent,
      elevation: 10,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(29.0),
                bottomRight: Radius.circular(29.0))),
      ),
      title:
      const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "SIGN UP",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),);
  }
}


class _singupState extends State<singup  > {
  bool _isHidden1=true;
  bool _isHidden2=true;

  var Gender_check = "";
  var Gov_check = "";

  bool _isPasswordEightCharacters = false;
  bool _hasPasswordLowerUpperCase = false;
  bool _hasPasswordSymbol = false;
  bool _hasPasswordNumber = false;


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

  var imgstate;
  var imgbcc;
  var imgicon;

  @override
  void initState() {
    super.initState();
    setState(() {
      imgpicked = null;
      imgstate = 'Insert Image';
      imgbcc = Colors.grey;
      imgicon = Icons.person_add;
    });
  }

  final _formkey = GlobalKey<FormState>();

   TextEditingController _firstnamecontroller = TextEditingController();
  TextEditingController _lastnamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _cPasswordcontroller = TextEditingController();
   TextEditingController _phonecontroller = TextEditingController();


  String dropdownvalue_gender = "Select your Gender";
  var gender = ["Select your Gender","Male","female"];

  String dropdownvalue_governorate = 'Select your City';
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


  bool isNumError = false;

  bool? value;

  @override
  void dispose() {
    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
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
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: _buildappbar(),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: HexColor('#80858E'),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Please upload your photo',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(optional)',
                              style: TextStyle(
                                  fontSize: 14, color: HexColor('#929292')),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: imgbcc,
                                  child: Icon(
                                    imgicon,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '$imgstate',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                            onTap: () async {
                              await _pickImage(context);
                              if (imgpicked != null) {
                                setState(() {
                                  imgstate = 'Image Inserted';
                                  imgbcc = Colors.greenAccent;
                                  imgicon = Icons.image;
                                });
                                imgname = basename(file.path);
                                var random = Random().nextInt(100000000);
                                imgname = "$random$imgname";
                              }
                            },
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: TextFormField(
                                controller: _firstnamecontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),

                                  labelText: 'First Name',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Enter your first name',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    print('value=$value');
                                    return 'Please Fill First Name Input';
                                  }
                                  return null;
                                }
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: TextFormField(
                                controller: _lastnamecontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),

                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Enter your last name',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    print('value=$value');
                                    return 'Please Fill last name Input';
                                  }
                                  return null;
                                }
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                                controller: _emailcontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),

                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Enter your Email address',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    print('value=$value');
                                    return 'Please Fill Email Input';
                                  }
                                  return null;
                                }
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: TextFormField(
                                controller: _phonecontroller,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),
                                  prefixText: '+2   ',

                                  labelText: 'Mobile',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Enter your Phone Number',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                ),
                                onChanged: (value){
                                  if(value[0] == '0' && value[1] == '1' &&(value[2] == '0' || value[2] == '2'|| value[2] == '1'|| value[2] == '5')&& value.length == 11){
                                    setState(() {
                                      isNumError = false;
                                    });
                                  }else {
                                    setState(() {
                                      isNumError = true;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    print('value=$value');
                                    return 'Please Fill Phone Input';
                                  }
                                  return null;
                                }
                            ),
                          ),
                          isNumError ?  Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "please enter validate number",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ):Container(),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: HexColor('#80858E'),
                              ),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: SizedBox(),
                              value: dropdownvalue_gender,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down),
                              items: gender.map((String items) {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "$Gender_check",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: HexColor('#80858E'),
                              ),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: SizedBox(),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "$Gov_check",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Center(
                            child: TextFormField(
                                onChanged: (password) =>
                                    onPasswordChange(password),
                                obscureText: _isHidden1,
                                controller: _passwordcontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.lock,
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
                                    return 'Please Fill Password Input';
                                  }else if(!_isPasswordEightCharacters || !_hasPasswordLowerUpperCase || !_hasPasswordSymbol ){
                                    return 'Please validate Password Input';
                                  }else
                                    return null;
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: _isPasswordEightCharacters
                                              ? Colors.green
                                              : Colors.transparent,
                                          border: _isPasswordEightCharacters
                                              ? Border.all(
                                              color: Colors.transparent)
                                              : Border.all(
                                              color: Colors.green.shade400),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Contains at least 8 characters')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: _hasPasswordLowerUpperCase
                                              ? Colors.green
                                              : Colors.transparent,
                                          border: _hasPasswordLowerUpperCase
                                              ? Border.all(
                                              color: Colors.transparent)
                                              : Border.all(
                                              color: Colors.green.shade400),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Contains lowercase & uppercase')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: _hasPasswordNumber
                                              ? Colors.green
                                              : Colors.transparent,
                                          border: _hasPasswordNumber
                                              ? Border.all(
                                              color: Colors.transparent)
                                              : Border.all(
                                              color: Colors.green.shade400),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Contains at least 1 number')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: _hasPasswordSymbol
                                              ? Colors.green
                                              : Colors.transparent,
                                          border: _hasPasswordSymbol
                                              ? Border.all(
                                              color: Colors.transparent)
                                              : Border.all(
                                              color: Colors.green.shade400),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Contains at least one symbol   [! @ # \$ % ^ & *]')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: TextFormField(
                                obscureText: _isHidden2,
                                controller: _cPasswordcontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Rebeat your password',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                          .withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: HexColor('#B3C3FF'),
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.lock,
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
                                    return 'Please Repeat Your Password';
                                  }else{
                                    return _passwordcontroller.text == value ? null : "Please Validate Your Entered Password";
                                  }
                                }),
                          ),

                          SizedBox(
                            height: 40,
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
                                onPressed: ()  {
                                  _Register(context);
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(height: 20),

                        ],
                      )),
                ),
                Image(
                  image: AssetImage('assets/footer.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPasswordChange(password) {
    final alphaRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])');
    final SymbolRegex = RegExp(r'^(?=.*?[!@#\$&*~])');
    final NumRegex = RegExp(r'^(?=.*?[0-9])');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordLowerUpperCase = false;
      if (alphaRegex.hasMatch(password)) _hasPasswordLowerUpperCase = true;

      _hasPasswordSymbol = false;
      if (SymbolRegex.hasMatch(password)) _hasPasswordSymbol = true;

      _hasPasswordNumber = false;
      if (NumRegex.hasMatch(password)) _hasPasswordNumber = true;

    });
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


  _Register(context)async{
    var x=_Gender_check();
    var y=_Gov_check();
  if(_formkey.currentState!.validate() && x && y && !isNumError) {
    _singup(context);
  }
}

  _singup(context) async {
    showLoading(context);
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      if (result != null)  {
        var uid = FirebaseAuth.instance.currentUser!.uid;
        print(uid);
        print(imgpicked);
        if (imgpicked != null) {
          print(imgname);
          print(file);
          var refstorage = await FirebaseStorage.instance
              .ref("users_profile_images/${imgname}");
          print(refstorage);
          await refstorage.putFile(file);
          print(imgname);
          var url = await refstorage.getDownloadURL();
          var userInfo = await FirebaseFirestore.instance
              .collection('users')
              .doc('$uid')
              .set({
            'first name': _firstnamecontroller.text,
            'last name': _lastnamecontroller.text,
            'email': _emailcontroller.text,
            'password': _passwordcontroller.text,
            'phone': _phonecontroller.text,
            'active balance': 0.0,
            'pending balance': 0.0,
            'image url': url,
            'userid': uid,
            'gender':dropdownvalue_gender,
            'city':dropdownvalue_governorate,
            'lang':'en',
            'token': '',
          });
        }
        else {
          print('no image');
          String url = dropdownvalue_gender == 'Male' ?
          "https://firebasestorage.googleapis.com/v0/b/bookingo-9e8aa.appspot.com/o/users_profile_images%2Fman_defult.png?alt=media&token=ca2c5b76-ed90-4a8d-a30f-9441c7e01bca"
          :"https://firebasestorage.googleapis.com/v0/b/bookingo-9e8aa.appspot.com/o/users_profile_images%2Fwoman_defult.png?alt=media&token=f8085b01-6646-4c79-aef4-9f4ba4ce13a0";
          var userInfo = await FirebaseFirestore.instance
              .collection('users')
              .doc('$uid')
              .set({
            'first name': _firstnamecontroller.text,
            'last name': _lastnamecontroller.text,
            'email': _emailcontroller.text,
            'password': _passwordcontroller.text,
            'phone': _phonecontroller.text,
            'active balance': 0.0,
            'pending balance': 0.0,
            'image url': url,
            'userid': uid,
            'gender':dropdownvalue_gender,
            'city':dropdownvalue_governorate,
            'lang':'en',
            'token': '',
          });
        }
        Navigator.of(context).pop();

        final snackBar = SnackBar(
            content: Text(
              'Accounts Created Successfully',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.lightGreen);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_page()),
        );
      } else {
        Navigator.of(context).pop();
        final snackBar = SnackBar(
            content: Text(
              'please try later!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => login()),
        );
        final snackBar = SnackBar(
            content: Text(
              'email already in use',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.code == 'invalid-email') {
        Navigator.of(context).pop();
        final snackBar = SnackBar(
            content: Text(
              'invalid email',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();
        final snackBar = SnackBar(
            content: Text(
              'weak password',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{print(e);}
    }
  }

}
_pickImage(context){
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please Choose Image',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              InkWell(
                onTap: ()async{
                  print('gallary');
                  imgpicked = await ImagePicker().getImage(source: ImageSource.gallery);
                  if(imgpicked != null){
                    print('gallary done');
                    file = File(imgpicked.path);
                    Navigator.of(context).pop();

                    final snackBar = SnackBar(
                        content: Text('Image Picked',
                          style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.lightGreen);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    final snackBar = SnackBar(
                        content: Text('Image Not Picked',
                          style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.photo_outlined,size: 30,),
                      SizedBox(width: 20),
                      Text('From Gallery',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()async{
                  print('camera');
                  imgpicked = await ImagePicker().getImage(source: ImageSource.camera);
                  if(imgpicked != null){
                    print('camera done');
                    file = File(imgpicked.path);
                    Navigator.of(context).pop();
                    final snackBar = SnackBar(
                        content: Text('Image Picked',
                          style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.lightGreen);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    final snackBar = SnackBar(
                        content: Text('Image Not Picked',
                          style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.camera,size: 30,),
                      SizedBox(width: 20),
                      Text('From Camera',
                        style: TextStyle(fontSize: 20,),
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




