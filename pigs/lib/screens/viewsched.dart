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
  List<String> c1_feedTime = ["", "", ""];
  List<String> c1_washTime = ["", "", ""];
  List<String> c1_bathTime = ["", "", ""];
  List<String> c2_feedTime = ["", "", ""];
  List<String> c2_washTime = ["", "", ""];
  List<String> c2_bathTime = ["", "", ""];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feed1scheds();
    _wash1scheds();
    _feed2scheds();
    _wash2scheds();
    _bath1scheds();
    _bath2scheds();
  }

  void _bath1scheds() async {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage1_bath_sched")
        .onValue
        .listen((event) {
      final List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        c1_bathTime[0] = data[0];
        c1_bathTime[1] = data[1];
        c1_bathTime[2] = data[2];
      });
    });
  }

  void _bath2scheds() async {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage2_bath_sched")
        .onValue
        .listen((event) {
      final List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        c2_bathTime[0] = data[0];
        c2_bathTime[1] = data[1];
        c2_bathTime[2] = data[2];
      });
    });
  }

  void _feed1scheds() async {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage1_feed_sched")
        .onValue
        .listen((event) {
      final List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        c1_feedTime[0] = data[0];
        c1_feedTime[1] = data[1];
        c1_feedTime[2] = data[2];
      });
    });
  }

  void _feed2scheds() async {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage2_feed_sched")
        .onValue
        .listen((event) {
      final List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        c2_feedTime[0] = data[0];
        c2_feedTime[1] = data[1];
        c2_feedTime[2] = data[2];
      });
    });
  }

  void _wash1scheds() async {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage1_wash_sched")
        .onValue
        .listen((event) {
      final List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        c1_washTime[0] = data[0];
        c1_washTime[1] = data[1];
        c1_washTime[2] = data[2];
      });
    });
  }

  void _wash2scheds() async {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage2_wash_sched")
        .onValue
        .listen((event) {
      final List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      setState(() {
        c2_washTime[0] = data[0];
        c2_washTime[1] = data[1];
        c2_washTime[2] = data[2];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scheds'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'CAGE 1',
              ),
              Tab(
                text: 'CAGE 2',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: DefaultTabController(
                length: 3,
                child: Container(
                  padding: EdgeInsets.all(32.0),
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        bottom: const TabBar(tabs: [
                          Tab(
                            text: 'FEED',
                          ),
                          Tab(
                            text: 'WASH',
                          ),
                          Tab(
                            text: 'BATH',
                          ),
                        ]),
                      ),
                    ),
                    body: TabBarView(children: [
                      Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c1_feedTime[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c1_feedTime[1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 350.0,
                            height: 50.0,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey),
                            child: Text(
                              c1_feedTime[2],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 300,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {
                              DatabaseReference _testRef = FirebaseDatabase
                                  .instance
                                  .ref("/cage1_feed_sched");
                              _testRef.update({"0": " "});
                              _testRef.update({"1": " "});
                              _testRef.update({"2": " "});
                            },
                            child: Text(
                              "RESET",
                            ),
                          )
                        ]),
                      ),
                      Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 350.0,
                            height: 50.0,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey),
                            child: Text(
                              c1_washTime[0],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c1_washTime[1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c1_washTime[2],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 300,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                DatabaseReference _testRef = FirebaseDatabase
                                    .instance
                                    .ref("/cage1_wash_sched");
                                _testRef.update({"0": " "});
                                _testRef.update({"1": " "});
                                _testRef.update({"2": " "});
                              },
                              child: Text("RESET"))
                        ]),
                      ),
                      Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c1_bathTime[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c1_bathTime[1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 350.0,
                            height: 50.0,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey),
                            child: Text(
                              c1_bathTime[2],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 300,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {
                              DatabaseReference _testRef = FirebaseDatabase
                                  .instance
                                  .ref("/cage1_bath_sched");
                              _testRef.update({"0": " "});
                              _testRef.update({"1": " "});
                              _testRef.update({"2": " "});
                            },
                            child: Text(
                              "RESET",
                            ),
                          )
                        ]),
                      ),
                    ]),
                  ),
                )),
          ),
          //CAGE2
          Center(
            child: DefaultTabController(
                length: 3,
                child: Container(
                  padding: EdgeInsets.all(32.0),
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        bottom: const TabBar(tabs: [
                          Tab(
                            text: 'FEED',
                          ),
                          Tab(
                            text: 'WASH',
                          ),
                          Tab(
                            text: 'BATH',
                          ),
                        ]),
                      ),
                    ),
                    body: TabBarView(children: [
                      Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_feedTime[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_feedTime[1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_feedTime[2],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 300,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                DatabaseReference _testRef = FirebaseDatabase
                                    .instance
                                    .ref("/cage2_feed_sched");
                                _testRef.update({"0": " "});
                                _testRef.update({"1": " "});
                                _testRef.update({"2": " "});
                              },
                              child: Text("RESET"))
                        ]),
                      ),
                      Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_washTime[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_washTime[1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_washTime[2],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 300,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                DatabaseReference _testRef = FirebaseDatabase
                                    .instance
                                    .ref("/cage2_wash_sched");
                                _testRef.update({"0": " "});
                                _testRef.update({"1": " "});
                                _testRef.update({"2": " "});
                              },
                              child: Text("RESET"))
                        ]),
                      ),
                      Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_bathTime[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_bathTime[1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 350.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Text(
                                c2_bathTime[2],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 300,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                DatabaseReference _testRef = FirebaseDatabase
                                    .instance
                                    .ref("/cage2_bath_sched");
                                _testRef.update({"0": " "});
                                _testRef.update({"1": " "});
                                _testRef.update({"2": " "});
                              },
                              child: Text("RESET"))
                        ]),
                      ),
                    ]),
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
