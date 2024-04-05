import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/token/all_tokens.dart';
import 'package:flutter_tv/token/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/constants.dart';
import 'doctor/doctor.dart';
import 'doctor/doctor_multiple.dart';
import 'doctor/doctor_three.dart';
import 'nurse/nurse.dart';
import 'otp/otp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    //clearing saved tokens
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (kIsWeb) {
      // web-specific setup
      var webInfo = await DeviceInfoPlugin().webBrowserInfo;
      // print('ios_id: ${webInfo.identifierForVendor}');
      // print('ios_model: ${webInfo.model}');
      // print('ios_name: ${webInfo.name}');
      // print('ios_device_version: ${webInfo.systemVersion}');
      // Constants.deviceID = '${webInfo.identifierForVendor}';
      // Constants.deviceModel = '${webInfo.model}_${webInfo.systemVersion}';
      print("webinfo");
      print(webInfo.toString());
      Constants.deviceID =
          '${webInfo.vendor}_${webInfo.userAgent}_${webInfo.hardwareConcurrency.toString()}';
      Constants.deviceModel = '${webInfo.vendor}_${webInfo.userAgent}';
      print('deviceId:${Constants.deviceID}');
    } else if (Platform.isAndroid) {
      // Android-specific setup
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.isPhysicalDevice) {
        print('android_id: ${androidInfo.id}');
        print(
            'android_device_name_version: ${androidInfo.model}_${androidInfo.version.release}');
        Constants.deviceID = androidInfo.id;
        Constants.deviceModel =
            '${androidInfo.model}_${androidInfo.version.release}';
      } else {
        print('on Emulator');
      }
    }
  } catch (e) {
    print(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterTV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/otp',
      routes: {
        '/token': (context) => const TokenScreen(),
        '/all-tokens': (context) => const AllTokenScreen(),
        '/otp': (context) => const OtpScreen(),
        '/doctor': (context) => const DoctorScreen(),
        '/three-doctors': (context) => const DoctorThree(),
        '/multiple-doctors': (context) => const DoctorMultiple(),
        '/nurse': (context) => const NurseScreen(),
      },
    );
  }
}
