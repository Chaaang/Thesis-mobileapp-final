import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewSched extends StatefulWidget {
  const ViewSched({Key? key}) : super(key: key);

  @override
  _ViewSchedState createState() => _ViewSchedState();
}

class _ViewSchedState extends State<ViewSched> {
  @override
  List<String> temp = [];
  List<String> wash = [];

  String f1 = "";
  String f2 = "";
  String f3 = "";
  String w1 = "";
  String w2 = "";
  String w3 = "";

  List<String> temp2 = [];
  List<String> wash2 = [];
  String f11 = "";
  String f22 = "";
  String f33 = "";
  String w11 = "";
  String w22 = "";
  String w33 = "";

  getfeed(String x) {
    final _testRef = FirebaseDatabase.instance
        .ref("cage1_feed_sched/" + x)
        .once()
        .then((event) {
      temp.add(jsonDecode(jsonEncode(event.snapshot.value)));
      // print(temp);
      setState(() {
        f1 = temp[0];
        f2 = temp[1];
        f3 = temp[2];
        //  print(f1);
      });
    });
  }

  getfeed2(String x) {
    final _testRef = FirebaseDatabase.instance
        .ref("cage2_feed_sched/" + x)
        .once()
        .then((event) {
      temp2.add(jsonDecode(jsonEncode(event.snapshot.value)));

      setState(() {
        f11 = temp2[0];
        f22 = temp2[1];
        f33 = temp2[2];
      });
    });
  }

  getwash(String x) {
    final _testRef = FirebaseDatabase.instance
        .ref("cage1_wash_sched/" + x)
        .once()
        .then((event) {
      wash.add(jsonDecode(jsonEncode(event.snapshot.value)));
      //  print(wash);
      setState(() {
        w1 = wash[0];
        w2 = wash[1];
        w3 = wash[2];
        //   print(w1);
      });
    });
  }

  getwash2(String x) {
    final _testRef = FirebaseDatabase.instance
        .ref("cage2_wash_sched/" + x)
        .once()
        .then((event) {
      wash2.add(jsonDecode(jsonEncode(event.snapshot.value)));
      //  print(wash);
      setState(() {
        w11 = wash2[0];
        w22 = wash2[1];
        w33 = wash2[2];
        //   print(w1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Schedule"),
        ),
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                for (int i = 0; i < 4; i++) {
                  getfeed(i.toString());
                }
                for (int i = 0; i < 4; i++) {
                  getwash(i.toString());
                }
              },
              child: Text("CAGE1")),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                buildRow(['FEED', 'WASH']),
                buildRow([f1, w1]),
                buildRow([f2, w2]),
                buildRow([f3, w3]),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                for (int i = 0; i < 4; i++) {
                  getfeed2(i.toString());
                }
                for (int i = 0; i < 4; i++) {
                  getwash2(i.toString());
                }
              },
              child: Text("CAGE2")),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                buildRow(['FEED', 'WASH']),
                buildRow([f11, w11]),
                buildRow([f22, w22]),
                buildRow([f33, w33]),
              ],
            ),
          ),
        ]));
  }

  TableRow buildRow(List<String> cells) => TableRow(
      children: cells
          .map((cell) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Text(
                  cell,
                  style: TextStyle(fontSize: 25),
                )),
              ))
          .toList());
}
