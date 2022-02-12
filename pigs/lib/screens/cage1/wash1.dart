import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_switch/flutter_switch.dart';

class Washing1 extends StatefulWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  _Washing1State createState() => _Washing1State();
}

class _Washing1State extends State<Washing1> {
  bool selected = false;
  String option = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WASHING"), centerTitle: true),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 1,
            child: buildSpecialAndroidSwitch(),
          ),
          SizedBox(height: 150),
          ElevatedButton(
              onPressed: null,
              child: Text(option),
              style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
        ],
      )),
    );
  }

  Widget buildSpecialAndroidSwitch() => Transform.scale(
      scale: 4,
      child: SizedBox(
          width: 75,
          child: Switch(
            trackColor: MaterialStateProperty.all(Colors.grey),
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
            value: selected,
            onChanged: (value) => setState(() {
              selected = value;
              if (selected == true) {
                wash(true);
                option = "ON";
              } else {
                wash(false);
                option = "OFF";
              }
            }),
          )));
  wash(bool x) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage_1").child("/wash_1");
    _testRef.set(x);
  }
}
