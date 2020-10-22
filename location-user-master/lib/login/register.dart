import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:seek4care_user/login/upload.dart';

class register extends StatefulWidget {
  static const String id = 'register.dart';

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  // widget.phone : is pre-validated


  // dob : is post-validated
  String dob;
  bool dobValid = false;

  // user name
  String name;
  bool nameValid = false;
  var nameRegex = RegExp(r'^[a-zA-z ]{3,25}$');

  // blood group
  int blood = 0;

  // gender : is pre-validated
  // true -> male ( by default )
  bool gender = true;

  // mail
  String mail;
  bool mailValid = false;
  var mailRegex =  RegExp(r'^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]{2,12}\.[a-zA-Z]{2,6})$');


  Future<Null> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2001, selectedDate.month, selectedDate.day),
        firstDate: DateTime(1920, selectedDate.month, selectedDate.day),
        lastDate: DateTime(2001, selectedDate.month, selectedDate.day));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    dob = selectedDate.toString().replaceAll(' 00:00:00.000', '');
    dob = dob.replaceAll('-', '');

    dobValid = true;
    print(dob);
  }

  void storeData() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    print(currentUser.phoneNumber.replaceAll('+91', ''));

    Firestore.instance
        .collection('users')
        .document(currentUser.phoneNumber.replaceAll('+91', ''))
        .setData
      ({
      'un':name,  // name
      'um':mail,  // mail
      'ug':gender,  // gender
      'ud':dob,  // dob
      'ub':blood,  // blood group
    });

    // After storing new user info into collection, we store some details in sharedPref
    sharedPref();

    // after storing in sharedPref we head to home page

    Navigator.of(context)
        .pushNamedAndRemoveUntil(upload.id, (Route<dynamic> route) => false);
  }

  sharedPref() async {
    // get shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set values
    setState(() {
      prefs.setBool  ('s4c_ul', true);  // sharedPref login check
      prefs.setBool  ('s4c_ug', gender);
      prefs.setInt   ('s4c_bg', blood);
      prefs.setString('s4c_um', mail);
      prefs.setString('s4c_un', name);
    });

    print('--------------STORED IN SHAREDPREF-----------');

    print('--------------ALL SEEMS OKAY-----------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // Name
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                  autovalidate: true,
                  validator: (value) {
                    if (nameRegex.hasMatch(value)) {
                      nameValid = true;
                      name = value;
                      return null;
                    } else
                      return 'do they really call you that ?';
                  },
                  maxLength: 25,
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'Name *',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w100),

                    //errorText: errorTxt,
                  )),
            ),
            // Email
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                  autovalidate: true,
                  validator: (value) {
                    if (mailRegex.hasMatch(value)) {
                      mailValid = true;
                      mail = value;
                      return null;
                    } else
                      return 'hey ! enter a valid mail ...';
                  },
                  maxLength: 35,
                  keyboardType: TextInputType.emailAddress,
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    hintText: 'E-mail *',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w100),

                    //errorText: errorTxt,
                  )),
            ),
            // Gender
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Male',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, //midnight blue
                    decoration: TextDecoration.none,
                    fontSize: 17,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Radio(
                  onChanged: (bool e) => genderRadio(e),
                  value: true,
                  groupValue: gender,
                ),
                Text(
                  'Female',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, //midnight blue
                    decoration: TextDecoration.none,
                    fontSize: 17,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Radio(
                  onChanged: (bool e) => genderRadio(e),
                  value: false,
                  groupValue: gender,
                ),
              ],
            ),
            // Blood Group
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.opacity,
                    color: Colors.red,
                  ),
                ),
                DropdownButton<int>(
                  items: [
                    DropdownMenuItem(value: 0, child: Text('A+')),
                    DropdownMenuItem(value: 1, child: Text('O-')),
                    DropdownMenuItem(value: 2, child: Text('B+')),
                    DropdownMenuItem(value: 3, child: Text('AB+')),
                    DropdownMenuItem(value: 4, child: Text('A-')),
                    DropdownMenuItem(value: 5, child: Text('O-')),
                    DropdownMenuItem(value: 6, child: Text('B-')),
                    DropdownMenuItem(value: 7, child: Text('AB-')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      blood = value;
                    });
                  },
                  hint: Text(
                    'Blood Group',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, //midnight blue
                      decoration: TextDecoration.none,
                      fontSize: 17,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  value: blood,
                ),
              ],
            ),
            // Date of Birth
            FlatButton(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 18.0, 18.0, 18.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Date of Birth',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white, //midnight blue
                        decoration: TextDecoration.none,
                        fontSize: 17,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: dobValid ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 250),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Please input dob ...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red, //midnight blue
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  _selectDate(context);
                }),

            // Terms Text
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'By clicking Register, you agree to our Terms.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white, //midnight blue
                  decoration: TextDecoration.none,
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            // Register Button
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedButton(
                  onPressed: () {
                    // register user & replace.push home

                    mailValid && nameValid && dobValid
                        ? storeData()
                        : print('something wrong!');
                  },
                  child: Text('Register')),
            ),
          ],
        ),
      ),
    );
  }

  void genderRadio(bool e) {
    setState(() {
      gender = e ? true : false;
    });
  }
}