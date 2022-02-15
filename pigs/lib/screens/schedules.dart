import 'package:flutter/material.dart';

import 'package:pigs/screens/feed_sched.dart';

import 'package:pigs/screens/wash_sched.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SCHEDULE"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedSchedule()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size(300, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text("FEED", style: TextStyle(fontSize: 35))),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WashSchedule()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size(300, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text("WASH", style: TextStyle(fontSize: 35))),
            ],
          ),
        ));
  }
}
