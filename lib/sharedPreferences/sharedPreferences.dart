import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferences {
  static SharedPreferences? preferences;
  static SharedPreferences? userData;


  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    userData = await SharedPreferences.getInstance();

  }


  static Set<String> getKeys() => preferences!.getKeys();



  static Future set( String date) async {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var x = List.generate(20, (index) => _chars[r.nextInt(_chars.length)])
        .join();
      await preferences!.setString(x, date);

  }

  static String? get(String id) => preferences!.getString(id);

  static Future<bool> delete(String id) => preferences!.remove(id);

  static Future<bool> clear() => preferences!.clear();



  static Set<String> getUserKeys() => userData!.getKeys();



  static Future setUser(String key ,String value) async {

    await userData!.setString(key, value);

  }

  static String? getUser(String id) => userData!.getString(id);

  static Future<bool> deleteUser(String id) => userData!.remove(id);

  static Future<bool> clearUser() => userData!.clear();



}