// Pinned for later as it requires firebase

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:seek4care_user/home/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class nurseServices extends StatefulWidget {
  static const String id = 'nurseServices.dart';

  @override
  _nurseServicesState createState() => _nurseServicesState();
}

class _nurseServicesState extends State<nurseServices> {
  List<dynamic> service = ['Nurse Services :'];
  List<bool> flag = [false];

  // initializing the services list
  @override
  void initState() {
    // TODO: implement initState
    fetchServices();
    super.initState();
  }

  // fetch services
  fetchServices() async {
    // fetch long services
    var longServices =
        await Firestore.instance.document('services/long_services').get();

    // fetch short services
    var shortServices =
        await Firestore.instance.document('services/short_services').get();

    setState(() {
      service = shortServices.data.values.toList();
      flag = List<bool>(service.length);
      flag.fillRange(0,service.length,false);

    });

    print(service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: service.length,
        itemBuilder: (context, index) {
          return Card(
            child: CheckboxListTile(
              title: Text('${service[index]}'),
              value: flag[index],
              onChanged: (bool value) {
                setState(() {
                  flag[index] = value;
                  print('${service[index]} is $value');
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // slValues
            final slValues = await SharedPreferences.getInstance();
            setState(() {
              // store the selected service in shared preferences
              //   slValues.setInt('s', service.indexOf(true));
            });
            //  print('service chosen is ${service.indexOf(true)}');

            // then go to next page
            Navigator.pushReplacementNamed(
              context,
              map.id,
            );
          },
          child: Icon(
            Icons.navigate_next,
          )),
    );
  }
}
