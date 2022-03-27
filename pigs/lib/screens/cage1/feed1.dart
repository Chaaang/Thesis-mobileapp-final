import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pigs/screens/settings.dart';

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  String display = "Result";
  int tank = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeight();
    getStatus();
  }

  void getWeight() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref()
        .child("cage_1/weight_1")
        .onValue
        .listen((event) {
      final String description = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        display = '$description';
      });
    });
  }

  void getStatus() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref()
        .child("cage_1/feed_tank_1")
        .onValue
        .listen((event) {
      final int data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        tank = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FEED'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text("Settings")),
                    const PopupMenuItem<int>(
                        value: 1, child: Text("Contact Us"))
                  ])
        ],
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "WEIGHT: " + display,
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            child: const Text(
              "FEED ME",
              style: TextStyle(fontSize: 35),
            ),
            onPressed: () {
              if (tank > 10) {
                feed("ON");
                Fluttertoast.showToast(
                    msg: "DONE",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                    fontSize: 20.0);
              } else {
                Fluttertoast.showToast(
                    msg: "Please refill the FEED TANK",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                    fontSize: 20.0);
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                fixedSize: const Size(300, 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        ]),
      ),
    );
  }

  feed(x) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref("/cage_1");
    _testRef.update({"feed_1": x});
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }
}
