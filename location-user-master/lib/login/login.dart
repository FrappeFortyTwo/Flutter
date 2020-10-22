import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:seek4care_user/home/home.dart';
import 'package:seek4care_user/login/register.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class login extends StatefulWidget {
  static const String id = 'login.dart';

  //login(this._scaffold);

  //final ScaffoldState _scaffold;
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId;
  bool visible = true;

  // phone number validation

  bool numValid = false;
  var numRegex = RegExp(r'^\d+$');

  GlobalKey phoneKey = GlobalKey();
  GlobalKey otpKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Stack(
        children: <Widget>[
          // phone box
          AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Column(
              children: <Widget>[
                // Enter Mobile Number Text
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 48, 12, 8),
                  child: Text(
                    _message,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                // Mobile Text Field
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                      key: phoneKey,
                      autovalidate: true,
                      autofocus: visible,
                      validator: (value) {
                        if (numRegex.hasMatch(value) && value.length == 10) {
                          numValid = true;
                          return null;
                        } else
                          return '10 digit number please';
                      },
                      controller: _phoneNumberController,
                      maxLength: 10,
                      enabled: true,
                      keyboardType: TextInputType.phone,
                      buildCounter: (BuildContext context,
                          {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                      null,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        ),
                        hintText: '8901234567',
                        prefixText: '+91 ',
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w100),

                        //errorText: errorTxt,
                      )),
                ),
                // Raised Button => _verifyPhoneNumber()
              ],
            ),
          ),
          // otp box

          AnimatedOpacity(
            opacity: visible ? 0.0 : 1,
            duration: Duration(milliseconds: 500),
            child: Column(
              children: <Widget>[
                // Enter OTP Number Text
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 48, 12, 8),
                  child: Text(
                    _message,
                   // 'Enter the 6-digit code sent to you.',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                // OTP Text Field
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                      enabled: !visible,
                      key: otpKey,
                      autovalidate: true,
                      autofocus: visible,
                      validator: (value) {
                        if (numRegex.hasMatch(value) && value.length == 6) {
                          numValid = true;
                          return null;
                        } else
                          return '6 digit otp , no please this time';
                      },
                      controller: _smsController,
                      maxLength: 6,
                      keyboardType: TextInputType.phone,
                      buildCounter: (BuildContext context,
                          {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                      null,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                        hintText: 'X X X X X X',
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w100),

                        //errorText: errorTxt,
                      )),
                ),
                // Raised Button => _signInWithPhoneNumber()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (numValid == true) {
            visible ? _verifyPhoneNumber() : _signInWithPhoneNumber();
          }
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.white24,
      ),
    );
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _neverSatisfied('Please check your phone for the verification code.');

      _verificationId = verificationId;
      setState(() {
        visible = !visible;
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + _phoneNumberController.text,
        timeout: const Duration(seconds: 0),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });

    // Navigate to Register if New User else head to home
    var userData = await Firestore.instance
        .document('users/$_phoneNumberController.text')
        .get();

    print('partner Data is $userData');

    if (!userData.exists) {
      print('ding ding ding!');
      print('------------ NEW USER ---------------------');
      // sending phone number into register page
      Navigator.pushReplacementNamed(
        context,
        register.id,
      );
    } else {
      // Retrieve data for pre-registered users
      print(userData.data);

      final prefs = await SharedPreferences.getInstance();

      // set values
      setState(() {
        prefs.setBool  ('s4c_ul', userData.data['l']); // login
        prefs.setInt   ('s4c_ub', userData.data['b']); // blood group
        prefs.setString('s4c_ud', userData.data['d']); // dob
        prefs.setBool  ('s4c_ug', userData.data['g']); // gender
        prefs.setString('s4c_um', userData.data['m']); // mail
        prefs.setString('s4c_un', userData.data['n']); // name
      });

      // then head home
      Navigator.pushReplacementNamed(context, home.id);
    }
  }

  Future<void> _neverSatisfied(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
