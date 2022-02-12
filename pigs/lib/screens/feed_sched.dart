import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pigs/screens/viewsched.dart';

class FeedSchedule extends StatefulWidget {
  @override
  _FeedScheduleState createState() => _FeedScheduleState();
}

class _FeedScheduleState extends State<FeedSchedule> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 1, minute: 11);
  String time_temp = "";
  bool isCheck = false;
  bool isCheck2 = false;
  int cage1_id = 1;
  int cage2_id = 1;

  void time() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {
              setState(() {
                timeOfDay = value!;
                time_temp = timeOfDay.format(context).toString();
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("FEED SCHEDULE"),
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                          value: 0, child: Text("View Sched")),
                    ])
          ]),
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
                        if (cage1_id == 4) {
                          null;
                        } else {
                          setState(() {
                            isCheck = value!;
                          });
                        }
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
                        if (cage2_id == 4) {
                          null;
                        } else {
                          setState(() {
                            isCheck2 = value!;
                          });
                        }
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
                  setState(() {
                    isCheck = false;
                    isCheck2 = false;
                  });
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
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage1_feed_sched");

    _testRef.update({cage1_id.toString(): cage1});
  }

  sched2(String cage2) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage2_feed_sched");
    _testRef.update({cage2_id.toString(): cage2});
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewSched()));
        break;
    }
  }
}
