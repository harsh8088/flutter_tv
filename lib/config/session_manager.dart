import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  /// Instantiation of the SharedPreferences library
  /// UserInfo
  static const String KEY_LOGIN_USER = "LoginUser";

  Future<void> setNurseToken(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<dynamic> getNurseToken(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<void> removeNurseToken(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<void> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("TOKEN", value);
  }

  Future<dynamic> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("TOKEN");
  }

  Future<dynamic> clearAll() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // var attendance = pref.get("ATTENDANCE");
    pref.clear();
    // pref.setString("ATTENDANCE", attendance.toString());
  }

  Future<dynamic> getAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final prefsMap = <String, dynamic>{};
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    print(prefsMap);
    return prefsMap;
  }
}
