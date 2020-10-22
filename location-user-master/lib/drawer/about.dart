import 'package:flutter/material.dart';
import 'package:seek4care_user/drawer/drawerOnly.dart';

class about extends StatelessWidget {
  static const String id = 'about.dart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerOnly(),
    );
  }
}
