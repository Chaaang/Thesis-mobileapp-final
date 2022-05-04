import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_switch/flutter_switch.dart';

class Washing2 extends StatefulWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  _Washing2State createState() => _Washing2State();
}

class _Washing2State extends State<Washing2> {
  bool selected = false;
  String option = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SANITATION"), centerTitle: true),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: const Text(
              'WASH',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              wash("ON");
              Fluttertoast.showToast(
                  msg: "DONE",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  fontSize: 20.0);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 200),
              shape: const CircleBorder(),
            ),
          ),
          ElevatedButton(
            child: const Text(
              'BATH',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              bath("ON");
              Fluttertoast.showToast(
                  msg: "DONE",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  fontSize: 20.0);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 200),
              shape: const CircleBorder(),
            ),
          )
        ],
      )),
    );
  }

  wash(String x) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage_2").child("/wash_2");
    _testRef.set(x);

    Future.delayed(Duration(milliseconds: 5000), () {
      _testRef.set("OFF");
      setState(() {
        selected = false;
        option = "OFF";
      });
    });
  }

  bath(String x) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage_2").child("/bath_2");
    _testRef.set(x);

    Future.delayed(Duration(milliseconds: 5000), () {
      _testRef.set("OFF");
      setState(() {
        selected = false;
        option = "OFF";
      });
    });
  }
}
