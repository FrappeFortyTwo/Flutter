import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seek4care_user/drawer/bookings.dart';
import 'package:seek4care_user/drawer/terms.dart';
import 'package:seek4care_user/drawer/about.dart';
import 'package:seek4care_user/home/home.dart';
import 'package:seek4care_user/login/login.dart';

class drawerOnly extends StatelessWidget {
  static const String id = 'drawerOnly.dart';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
              accountName: Text(
                "Seek4Care",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              accountEmail: Text(
                "care@seek4care.com",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white70,
                child: Text(
                  "A",
                  style: TextStyle(
                      fontSize: 30.0, color: Color.fromRGBO(58, 66, 86, 1.0)),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        home.id, (Route<dynamic> route) => false);
                  }, // Go to Home Page
                  title: Text("Home", style: TextStyle(color: Colors.white)),
                  subtitle: Text("some stuff ...",
                      style: TextStyle(color: Colors.white70)),
                  leading: Icon(Icons.home, color: Colors.white),
                ),
                Divider(
                  color: Colors.white24,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        home.id, (Route<dynamic> route) => false);
                    Navigator.pushNamed(context, bookings.id);
                  }, // Go to Bookings Page
                  title:
                  Text("Bookings", style: TextStyle(color: Colors.white)),
                  subtitle: Text("some stuff again ...",
                      style: TextStyle(color: Colors.white70)),
                  leading: Icon(Icons.today, color: Colors.white),
                ),
                Divider(
                  color: Colors.white24,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        home.id, (Route<dynamic> route) => false);
                    Navigator.pushNamed(context, terms.id);
                  }, // Go to Terms Page
                  title: Text("Terms & Conditions",
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text("some stuff ...",
                      style: TextStyle(color: Colors.white70)),
                  leading: Icon(Icons.warning, color: Colors.white),
                ),
                Divider(
                  color: Colors.white24,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        home.id, (Route<dynamic> route) => false);
                    Navigator.pushNamed(context, about.id);
                  }, // Go to About Page
                  title:
                  Text("About Us", style: TextStyle(color: Colors.white)),
                  subtitle: Text("some stuff again ...",
                      style: TextStyle(color: Colors.white70)),
                  leading: Icon(Icons.toys, color: Colors.white),
                ),
                Divider(
                  color: Colors.white24,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        login.id, (Route<dynamic> route) => false);
                  }, // Go to Login Page
                  title: Text("Logout", style: TextStyle(color: Colors.white)),
                  subtitle: Text("some stuff ...",
                      style: TextStyle(color: Colors.white70)),
                  leading: Icon(Icons.launch, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}