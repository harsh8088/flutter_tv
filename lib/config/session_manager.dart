import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

/// Instantiation of the SharedPreferences library
class SessionManager {
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

  Future<void> setDoctorScreenType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("DOCTOR_SCREEN_TYPE", value);
  }

  Future<dynamic> getDoctorScreenType() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey("DOCTOR_SCREEN_TYPE")) {
        return pref.getString("DOCTOR_SCREEN_TYPE");
      } else {
        return ' Single Doctor';
      }
    } catch (e) {
      print(e);
      return ' Single Doctor';
    }
  }

  Future<void> setTokenScreenType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("TOKEN_SCREEN_TYPE", value);
  }

  Future<dynamic> getTokenScreenType() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey("TOKEN_SCREEN_TYPE")) {
        return pref.getString("TOKEN_SCREEN_TYPE");
      } else {
        return ' Called Tokens';
      }
    } catch (e) {
      print(e);
      return ' Called Tokens';
    }
  }

  Future<List<String>> getSavedCounterList(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? result = prefs.getStringList(key);
      print("result:$result");
      if (result != null) {
        return result;
      } else {
        return List<String>.empty(growable: true);
      }
    } catch (e) {
      print(e);
      return List<String>.empty(growable: true);
    }
  }

  Future<void> setSavedCounterList(List<String> value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(Constants.keyCounters, value);
    } catch (_) {}
  }
}
