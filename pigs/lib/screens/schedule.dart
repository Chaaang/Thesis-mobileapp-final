import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 1, minute: 11);
  String time_temp = "";
  bool isCheck = false;
  bool isCheck2 = false;
  int cage1_id = 0;
  int cage2_id = 0;

  void time() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {
              setState(() {
                timeOfDay = value!;
                time_temp = timeOfDay.format(context).toString();
                print(time_temp);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SCHEDULE"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              time_temp,
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  time();
                  // holder++;
                  // print(holder);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    fixedSize: const Size(300, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child:
                    const Text("Choose Time", style: TextStyle(fontSize: 35))),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 100)),
                Transform.scale(
                  scale: 3.0,
                  child: Checkbox(
                      value: isCheck,
                      onChanged: (value) {
                        setState(() {
                          isCheck = value!;
                        });
                      }),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "CAGE1",
                  style: TextStyle(fontSize: 50),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 100)),
                Transform.scale(
                  scale: 3.0,
                  child: Checkbox(
                      value: isCheck2,
                      onChanged: (value) {
                        setState(() {
                          isCheck2 = value!;
                        });
                      }),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "CAGE2",
                  style: TextStyle(fontSize: 50),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  if (isCheck == true && isCheck2 == true) {
                    sched1(time_temp);
                    sched2(time_temp);
                    cage1_id++;
                    cage2_id++;
                  } else if (isCheck == true && isCheck2 == false) {
                    sched1(time_temp);
                    cage1_id++;
                  } else if (isCheck2 == true && isCheck == false) {
                    sched2(time_temp);
                    cage2_id++;
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    fixedSize: const Size(300, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text("Submit", style: TextStyle(fontSize: 35))),
          ],
        ),
      ),
    );
  }

  sched1(String cage1) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref("/cage1_sched");

    _testRef.update({cage1_id.toString(): cage1});
  }

  sched2(String cage2) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref("/cage2_sched");
    _testRef.update({cage2_id.toString(): cage2});
  }
}
