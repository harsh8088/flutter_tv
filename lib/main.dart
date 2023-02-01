import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/token/token.dart';
import 'package:http/http.dart' as http;

import 'config/constants.dart';
import 'doctor/doctor.dart';
import 'nurse/nurse.dart';
import 'otp/otp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
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
        '/otp': (context) => const OtpScreen(),
        '/doctor': (context) => const DoctorScreen(),
        '/nurse': (context) => const NurseScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    startObservers();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startObservers() async {
    Timer.periodic(const Duration(seconds: 6), (Timer t) => fetchData(123));
  }

  Future<dynamic> fetchData(int? bookingID) async {
    try {
      final uri = Uri.parse(
          'https://sandboxapiportal.mhea.myhealthcare.co/api/qms/android/v1/display-tv');
      var mHeaders = {
        'Content-Type': 'application/json',
      };
      var body = {"device_id": "4337723cdb9f13f9"};
      var mbody = json.encode(body);
      // await Future.delayed(Duration(seconds: 2));
      final response = await http.post(uri, headers: mHeaders, body: mbody);
      print('>req.url:$uri');
      print('headers: ${mHeaders.toString()}');
      print('>req.body:${mbody.toString()}');
      print('<-- body: ${response.statusCode} , ${response.body}');
      var resDecode = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (resDecode['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (_) {
      print(_.toString());
      return false;
    }
  }
}
