import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seek4care_user/login/login.dart';
import 'package:seek4care_user/login/register.dart';
import 'package:seek4care_user/login/upload.dart';
import 'package:seek4care_user/login/flash.dart';
import 'package:seek4care_user/home/home.dart';
import 'package:seek4care_user/home/map.dart';
import 'package:seek4care_user/home/nurseForm.dart';
import 'package:seek4care_user/home/nurseServices.dart';
import 'package:seek4care_user/home/result.dart';



class routes extends StatefulWidget {
  @override
  _routesState createState() => _routesState();
}

class _routesState extends State<routes> {
  Widget defHome = flash();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // call sharedPref()
    sharedPref();
  }

  void sharedPref() async {
    final prefs = await SharedPreferences.getInstance();

    // Try reading pass. If it doesn't exist, return 0.
    setState(() {
      defHome = prefs.getBool('s4c_ul') == null ? flash() : home();

      print('----------CHECKING PASS VALUE----------');
      print(prefs.getBool('s4c_ul') == null
          ? '----------------NEW USER------REGISTER PLEASE---------'
          : '----------------OLD USER------HEAD HOME-------------');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // if new then login else home
      home: defHome,
      //home: register(),
      routes: {
        login.id: (context) => login(),
        home.id: (context) => home(),
        register.id: (context) => register(),
        upload.id: (context) => upload(),
        home.id: (context) => home(),
        map.id: (context) => map(),
        nurseForm.id: (context) => nurseForm(),
        nurseServices.id: (context) => nurseServices(),
        result.id: (context) => result(),
      },
    );
  }
}