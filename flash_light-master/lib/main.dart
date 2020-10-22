import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torch/torch.dart';

void main() => runApp(flash_light());

class flash_light extends StatefulWidget {
  @override
  _flash_lightState createState() => _flash_lightState();
}

class _flash_lightState extends State<flash_light> {
  bool _switchVal = true; // true -> OFF && false -> ON
  bool _flickVal = false;
  double _sliderVal = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _switchVal ? Colors.white12 : Colors.amberAccent,
        appBar: AppBar(
          backgroundColor: _switchVal ? Colors.blueAccent : Colors.redAccent,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Transform.rotate(
                angle: pi / 2,
                child: Transform.scale(
                  scale: 4,
                  child: Switch(
                    activeTrackColor: Colors.blueGrey,
                    activeColor: Colors.blueAccent,
                    inactiveTrackColor: Colors.teal,
                    inactiveThumbColor: Colors.redAccent,
                    value: _switchVal,
                    onChanged: (bool val) {
                      setState(() {
                        if (_flickVal == true) _flickVal = !_flickVal;
                        _switchVal = !_switchVal;
                      });

                      _switchVal ? Torch.turnOff() : Torch.turnOn();
                    },
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Slider(
                activeColor: _switchVal ? Colors.blueAccent : Colors.redAccent,
                inactiveColor: _switchVal ? Colors.white12 : Colors.teal,
                min: 0.0,
                max: 1000.0,
                divisions: 4,
                value: _sliderVal,
                label: '${_sliderVal.floor()}',
                onChanged: (double val) {
                  setState(() {
                    _sliderVal = val;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  valPoints('0ms'),
                  valPoints('250ms'),
                  valPoints('500ms'),
                  valPoints('750ms'),
                  valPoints('1000ms'),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                width: 260,
                height: 60,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (_switchVal == false) {
                        Torch.turnOff();
                        _switchVal = true;
                      }
                      _flickVal = !_flickVal;
                    });
                    flicker();
                  },
                  color: _switchVal ? Colors.blueAccent : Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'FLICKER',
                        style: TextStyle(
                          letterSpacing: 7.0,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        _flickVal ? Icons.flash_off : Icons.flash_on,
                        color: _flickVal ? Colors.white : Colors.amberAccent,
                      )
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void flicker() async {
    for (;;) {
      if (_flickVal == false) break;
      await Torch.flash(Duration(milliseconds: _sliderVal.floor()));
    }
  }

  Text valPoints(String msg) {
    return Text(
      msg,
      style: TextStyle(
          wordSpacing: 7.0,
          color: _switchVal ? Colors.blueAccent : Colors.redAccent),
    );
  }
}
