import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bookingo/get_start/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Home_page/Home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/logo.png',

      screenFunction: () async {
        instance.authStateChanges().listen(
              (user) async {
            if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Home_page()),
                  );
                }
            else if (user == null) {
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(builder: (context) => welcome()),
              );
            }
          },
        );
        return Container();
      },
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
