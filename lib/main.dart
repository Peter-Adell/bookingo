
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'get_start/splash_screen.dart';
import 'gsheets/sheets_api.dart';
import 'sharedPreferences/sharedPreferences.dart';

///Receive message when app is in background solution for on message


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SheetsApi.init();
  await sharedPreferences.init();

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}


