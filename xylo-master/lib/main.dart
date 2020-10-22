import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(xylo());

class xylo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white12,
          body: Column(
            children: <Widget>[
              xyloTile('note1.wav', Colors.red),
              xyloTile('note2.wav', Colors.amber),
              xyloTile('note3.wav', Colors.blue),
              xyloTile('note4.wav', Colors.brown),
              xyloTile('note5.wav', Colors.deepOrange),
              xyloTile('note6.wav', Colors.green),
              xyloTile('note7.wav', Colors.purple),
            ],
          ),
        ),
      ),
    );
  }

  Expanded xyloTile(String wav, Color shade) {
    return Expanded(
      flex: 1,
      child: Card(
        color: shade,
        child: FlatButton(
          splashColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                color: Colors.black38,
              ),
              Icon(
                Icons.add_circle_outline,
                color: Colors.black38,
              ),
            ],
          ),
          onPressed: () {
            final player = AudioCache();
            player.play(
              wav,
              volume: 1.0,
            );
          },
        ),
      ),
    );
  }
}
