import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class nurseForm extends StatefulWidget {
  static const String id = 'nurseForm.dart';

  @override
  _nurseFormState createState() => _nurseFormState();
}

class _nurseFormState extends State<nurseForm> {
  // pName
  String name;
  GlobalKey nameKey;
  bool nameValid = false;
  var nameRegex = RegExp(r'^[a-zA-z- ]{3,25}$');

  // pPhone
  String phone;
  GlobalKey phoneKey = GlobalKey();
  bool phoneValid = false;
  var numRegex = RegExp(r'^\d+$');

  // pAge
  String age;
  GlobalKey ageKey = GlobalKey();
  bool ageValid = false;
  // using numRegex from phone input

  // pGender
  bool gender = true;

  // pAddress
  String add;
  GlobalKey addKey;
  bool addValid = false;
  var addRegex = RegExp(r'^[a-zA-z0-9,. ]{3,25}$');

  // check is coordinates are valid

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // Patient Name
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
                  maxLength: 30,
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
                    hintText: 'Patient Name *',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w100),

                    //errorText: errorTxt,
                  )),
            ),

            // Patient Gender
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  onChanged: (bool e) => pGenderRadio(e),
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
                  onChanged: (bool e) => pGenderRadio(e),
                  value: false,
                  groupValue: gender,
                ),
              ],
            ),

            // Patient Age
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                  keyboardType: TextInputType.phone,
                  maxLength: 2,
                  autovalidate: true,
                  validator: (value) {
                    if (numRegex.hasMatch(value) && value.length == 2) {
                      age = value;
                      ageValid = true;
                      return null;
                    } else
                      return 'age is just a number :)';
                  },
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    hintText: 'Patient Age *',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w100),

                    //errorText: errorTxt,
                  )),
            ),

            // Patient Phone
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  autovalidate: true,
                  validator: (value) {
                    if (numRegex.hasMatch(value) && value.length == 10) {
                      phone = value;
                      phoneValid = true;
                      return null;
                    } else
                      return '10 digit number please';
                  },
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone_android,
                      color: Colors.white,
                    ),
                    hintText: 'Patient Phone *',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w100),

                    //errorText: errorTxt,
                  )),
            ),

            // Patient Address
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                  maxLength: 50,
                  autovalidate: true,
                  validator: (value) {
                    if (addRegex.hasMatch(value)) {
                      add = value;
                      addValid = true;
                      return null;
                    } else
                      return 'No fictional addresses please... ?';
                  },
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    hintText: 'Patient Address *',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w100),

                    //errorText: errorTxt,
                  )),
            ),

            // Select Address

            // Submit Form
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedButton(
                  onPressed: () async {
                    // Get basic info of patient
                    // Get Map Location
                    if (nameValid && ageValid && phoneValid && addValid) {
                      // code to fetch location & service
                      final sl = await SharedPreferences.getInstance();

                      print('lat is ${sl.getString('lat')}');
                      print('long is ${sl.getString('long')}');
                      print('service is ${sl.getInt('s')}');

                      // send data into request database queue
                      print('all seems fine ! uploading to RL db !');

//                      database.reference().child("request").set({
//                        // upload data
//                        'name': name,
//                        'gender': gender,
//                        'age': age,
//                        'phone': phone,
//                        'add': add,
//                      });
                    }
                  },
                  child: Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }

  void pGenderRadio(bool e) {
    setState(() {
      if (e == true)
        gender = true;
      else if (e == false) gender = false;
    });
  }
}