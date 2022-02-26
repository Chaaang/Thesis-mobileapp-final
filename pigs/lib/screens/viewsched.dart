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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          final data = snapshot.data as List<List<String>>;
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
                    child: ListView(
                  children: [
                    const Center(child: Text("FEED")),
                    TextButton(onPressed: () {}, child: Text(data[0][0])),
                    TextButton(onPressed: () {}, child: Text(data[0][1])),
                    TextButton(onPressed: () {}, child: Text(data[0][2])),
                    const Center(child: Text("WASH")),
                    TextButton(onPressed: () {}, child: Text(data[2][0])),
                    TextButton(onPressed: () {}, child: Text(data[2][1])),
                    TextButton(onPressed: () {}, child: Text(data[2][2])),
                  ],
                )),
                Center(
                  child: Text("CAGE 2"),
                )
              ]),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  getData() async {
    List<String> c1feedsched = [];
    List<String> c2feedsched = [];
    List<String> c1washsched = [];
    List<String> c2washsched = [];
    //getfeed1_time
    var x = await FirebaseDatabase.instance
        .ref("cage1_feed_sched")
        .orderByKey()
        .get();
    var y = jsonDecode(jsonEncode(x.value)) as List<dynamic>;

    for (int i = 0; i < y.length; i++) {
      c1feedsched.add(y[i]);
    }
    print(c1feedsched);

    //getfeed2_time
    var a = await FirebaseDatabase.instance
        .ref("cage2_feed_sched")
        .orderByKey()
        .get();
    var b = jsonDecode(jsonEncode(a.value)) as List<dynamic>;

    for (int i = 0; i < b.length; i++) {
      c2feedsched.add(b[i]);
    }
    print(c2feedsched);

    //getwash1_time
    var c = await FirebaseDatabase.instance
        .ref("cage1_wash_sched")
        .orderByKey()
        .get();
    var d = jsonDecode(jsonEncode(c.value)) as List<dynamic>;

    for (int i = 0; i < d.length; i++) {
      c1washsched.add(d[i]);
    }
    print(c1washsched);

    //getwash2_time
    var e = await FirebaseDatabase.instance
        .ref("cage2_wash_sched")
        .orderByKey()
        .get();
    var f = jsonDecode(jsonEncode(e.value)) as List<dynamic>;

    for (int i = 0; i < f.length; i++) {
      c2washsched.add(f[i]);
    }
    print(c2washsched);
    return [c1feedsched, c2feedsched, c1washsched, c2washsched];
  }
}
