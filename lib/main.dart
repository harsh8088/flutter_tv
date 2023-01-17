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
    print('${e.toString()}');
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isRunning = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startObservers();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
        if (resDecode['status'] == true)
          return true;
        else
          return false;
      } else
        return false;
    } catch (_) {
      print(_.toString());
      return false;
    }
  }
}
