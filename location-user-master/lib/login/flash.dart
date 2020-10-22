import 'package:flutter/material.dart';
import 'package:seek4care_user/login/login.dart';

class flash extends StatefulWidget {
  static const String id = 'login.dart';
  @override
  _flashState createState() => _flashState();
}

class _flashState extends State<flash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.4],
                colors: [Color.fromRGBO(58, 66, 86, 1.0), Colors.white])),
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 10,
            ),
            Text(
              'seek4care',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 48,
                  color: Colors.white, //midnight blue
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w100),
            ),
            Spacer(
              flex: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lorem ipsum dolor sit',
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Color.fromRGBO(58, 66, 86, 1.0), //midnight blue
                  decoration: TextDecoration.none,
                  fontSize: 22,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),

              child: InkWell(
                onTap: () {
                  // Move to Phone Screen
                  Navigator.pushNamed(context, login.id);
                },
                child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                  decoration: InputDecoration(
                    //filled: true,
                      icon: Icon(
                        Icons.phone,
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                      ),
                      hintText: 'Enter your mobile number',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(58, 66, 86, 1.0),
                          fontWeight: FontWeight.w100)),
                ),
              ),
              //),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              'get to know us',
              textAlign: TextAlign.left,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Color.fromRGBO(58, 66, 86, 1.0), //belize hole
                decoration: TextDecoration.none,
                fontSize: 16,
                fontWeight: FontWeight.w100,
              ),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}