import 'package:flutter/material.dart';
import 'package:seek4care_user/drawer/drawerOnly.dart';

class terms extends StatelessWidget {
  static const String id = 'terms.dart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerOnly(),
    );
  }
}
