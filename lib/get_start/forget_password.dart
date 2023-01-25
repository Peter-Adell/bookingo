import 'package:bookingo/get_start/singup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../component/loading.dart';
import 'login.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key? key}) : super(key: key);

  @override
  State<forget_password> createState() => _forget_passwordState();
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
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(29.0),
                bottomRight: Radius.circular(29.0))),
      ),
      title: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "Forget Password",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _forget_passwordState extends State<forget_password> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();

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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: _buildappbar(),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[

                                Row(
                                  children: const [
                                    Text(
                                      'Enter Email:',
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: TextFormField(
                                      controller: _emailcontroller,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 15),
                                        prefixIcon: const Icon(Icons.mail_outline_outlined,
                                            color: Colors.black45),
                                        labelText: 'Email Address',
                                        labelStyle: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor("#205072")),
                                        hintText: 'Ex email@email.com',
                                        hintStyle: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                HexColor("#205072").withOpacity(0.5)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: HexColor('#B3C3FF'),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          print('value=$value');
                                          return 'Please Fill Email Input';
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Please check your email to Reset your Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 50,
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
                                        offset: Offset(
                                            5, 10), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  width: 200,
                                  height: 55,
                                  child: new TextButton(
                                      style:
                                          TextButton.styleFrom(primary: Colors.white),
                                      onPressed: () async {
                                        _reset_password();

                                      },
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),

                              ],
                            )),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Image(
          image: AssetImage('assets/footer.png'),
        ),
      ),
    );
  }
  _reset_password(){
    if (_formkey.currentState!.validate()) {
      showLoading(context);
      try{
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailcontroller.text).then((value) {
          final snackBar = SnackBar(
              content: Text(
                'Email has been Sent Successfully to \n ${_emailcontroller.text}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.lightGreen);
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => login()),
          );        }
        ).catchError((e){
          print('e = ${e.code}');
          if(e.code == 'invalid-email'){
            Navigator.of(context).pop();
            final snackBar = const SnackBar(content: Text('invalid email',style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (e.code == 'user-not-found') {
            Navigator.of(context).pop();
            final snackBar = SnackBar(
                content: Text(
                  'user not found',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.redAccent);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });

      }catch(e){
        print(e);
      }
    }
  }
}
