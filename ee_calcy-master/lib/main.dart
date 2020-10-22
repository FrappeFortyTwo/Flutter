import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
  home: home(),
  routes: {
    home.id: (context) => home(),
  },
));
