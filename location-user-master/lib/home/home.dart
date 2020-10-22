import 'package:flutter/material.dart';
import 'package:seek4care_user/home/nurseServices.dart';
import 'package:seek4care_user/drawer/drawerOnly.dart';
import 'package:url_launcher/url_launcher.dart';

class home extends StatelessWidget {
  static const String id = 'home.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text('dummy'),
        ),
        drawer: drawerOnly(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: RaisedButton(
                onPressed: () {
                  // go to nurse form
                  Navigator.pushNamed(context, nurseServices.id);
                },
                child: Text('Book Nurse')),
          ),
        ),
        bottomNavigationBar: RaisedButton(
            color: Colors.blue,
            padding: const EdgeInsets.all(18.0),
            onPressed: () {
              // launch phone App through Url
              _launchURL('tel:+91 90996 06068');
            },
            child: Text(
              'Call Us !',
              style: TextStyle(color: Colors.white70),
            )));
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}