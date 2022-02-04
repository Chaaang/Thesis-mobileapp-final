import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pigs/screens/settings.dart';

class Feed2 extends StatefulWidget {
  @override
  State<Feed2> createState() => _Feed2State();
}

class _Feed2State extends State<Feed2> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  String display = "Result";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activelistener();
  }

  void activelistener() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref()
        .child("cage_2/weight_2")
        .onValue
        .listen((event) {
      final String description = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        display = '$description';
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
              feed(true);
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

  feed(bool x) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref("/cage_2");
    _testRef.update({"feed_2": x});
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
