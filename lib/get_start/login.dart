import 'package:bookingo/get_start/reactivate_account.dart';
import 'package:bookingo/get_start/singup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Home_page/Home.dart';
import '../component/loading.dart';
import 'forget_password.dart';




class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
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
        onPressed: () =>  Navigator.pop(context)
      ),

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
      Padding(
          padding: EdgeInsets.only(top: 20),
          child: new Text(
            "Login",
            style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
      ),);
  }
}


class _loginState extends State<login> {

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  bool _isHidden = true;

  var pass_time=0;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

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
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height:200 ,
                  width: 150,
                  margin: EdgeInsets.only(top:20),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: TextFormField(
                                controller: _emailcontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15),
                                  prefixIcon: Icon(Icons.mail_outline_outlined,
                                      color: Colors.black45),
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#205072")
                                  ),
                                  hintText: 'Ex email@email.com',
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
                                  if (value == null || value.isEmpty) {
                                    print('value=$value');
                                    return 'Please Fill Email Input';
                                  }
                                  return null;
                                }
                            ),
                          ),

                          SizedBox(
                            height: 35,
                          ),
                          Center(
                            child: TextFormField(
                                obscureText: _isHidden,
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
                                    onTap: _togglePasswordView,
                                    child: Icon(
                                      Icons.visibility,
                                      color: HexColor("#496171")
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Fill Password Input';
                                  }
                                  return null;
                                }),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: HexColor('#484848'),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => forget_password(),
                                  ));
                            },
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
                                onPressed: () async {
                                      _SignIn();
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            child: Text(
                              'Don\'t have account ? Register Now ',
                              style: TextStyle(
                                  color: HexColor('#484848'),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => singup(),
                                  ));
                            },
                          ),
                        ],
                      )),
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

  _SignIn() async {
    showLoading(context);
    if(_formkey.currentState!.validate()){
        try{
          UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailcontroller.text, password: _passwordcontroller.text);
          if(credential != null){
            var uid = FirebaseAuth.instance.currentUser!.uid;
            print(uid);
            Navigator.of(context).pop();
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Home_page()),);
            print('login successfully');
          }
        }on FirebaseAuthException catch (e) {
          if(e.code == 'invalid-email'){
            Navigator.of(context).pop();
            final snackBar = SnackBar(content: Text('invalid email',style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if(e.code == 'user-disabled'){
            Navigator.of(context).pop();
            final snackBar = SnackBar(content: Text('user disabled',style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }
          if(e.code == 'user-not-found'){
            Navigator.of(context).pop();
            final snackBar = SnackBar(content: Text('user not found',style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }
          if(e.code == 'wrong-password'){
            pass_time++;
            Navigator.of(context).pop();
            final snackBar = SnackBar(content: Text('wrong password',style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }
        }

    }else if(!_formkey.currentState!.validate()){
      Navigator.of(context).pop();
    }
  }

}



