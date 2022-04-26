import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WashSchedule extends StatefulWidget {
  @override
  _WashScheduleState createState() => _WashScheduleState();
}

class _WashScheduleState extends State<WashSchedule> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 1, minute: 11);
  String time_temp = "";
  bool isCheck = false;
  bool isCheck2 = false;
  int cage1_id = 0;
  int cage2_id = 0;
  List<String> cageTime1 = [];
  List<String> cageTime2 = [];
  List<dynamic> cageBath1 = [];
  List<dynamic> cageFeed1 = [];
  List<dynamic> cageBath2 = [];
  List<dynamic> cageFeed2 = [];
  int cage1_key = 0;
  int cage2_key = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    _cageBath1();
    _cageFeed1();
    _cageBath2();
    _cageFeed2();
  }

  void _cageBath1() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage1_bath_sched")
        .onValue
        .listen((event) {
      cageBath1 = (jsonDecode(jsonEncode(event.snapshot.value)));
    });
  }

  void _cageFeed1() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage1_feed_sched")
        .onValue
        .listen((event) {
      cageFeed1 = (jsonDecode(jsonEncode(event.snapshot.value)));
    });
  }

  //2
  void _cageBath2() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage2_bath_sched")
        .onValue
        .listen((event) {
      cageBath2 = (jsonDecode(jsonEncode(event.snapshot.value)));
      print(cageBath2);
    });
  }

  void _cageFeed2() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref("cage2_feed_sched")
        .onValue
        .listen((event) {
      cageFeed2 = (jsonDecode(jsonEncode(event.snapshot.value)));
      print(cageFeed2);
    });
  }

  void time() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {
              setState(() {
                timeOfDay = value!;
                time_temp = timeOfDay.format(context).toString();
              })
            });
  }

  Future<void> getTime_C1(String x) async {
    await FirebaseDatabase.instance
        .ref("cage1_wash_sched/" + x)
        .once()
        .then((event) {
      cageTime1.add(jsonDecode(jsonEncode(event.snapshot.value)));
      cageTime1.sort((a, b) => parseTime(a).compareTo(parseTime(b)));
    });
  }

  Future<void> getTime_C2(String x) async {
    await FirebaseDatabase.instance
        .ref("cage2_wash_sched/" + x)
        .once()
        .then((event) {
      cageTime2.add(jsonDecode(jsonEncode(event.snapshot.value)));
      cageTime2.sort((a, b) => parseTime(a).compareTo(parseTime(b)));
    });
  }

  int parseTime(String time) {
    var components = time.split(RegExp('[: ]'));
    if (components.length != 3) {
      throw FormatException('Time not in the expected format: $time');
    }
    var hours = int.parse(components[0]);
    var minutes = int.parse(components[1]);
    var period = components[2].toUpperCase();

    if (hours < 1 || hours > 12 || minutes < 0 || minutes > 59) {
      throw FormatException('Time not in the expected format: $time');
    }

    if (hours == 12) {
      hours = 0;
    }

    if (period == 'PM') {
      hours += 12;
    }

    return hours * 100 + minutes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WASH SCHEDULE"),
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
                        if (cage1_id >= 3) {
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
                        if (cage2_id >= 3) {
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
                onPressed: () async {
                  if (isCheck == true && isCheck2 == true) {
                    if ((cageBath1.contains(time_temp) ||
                            cageFeed1.contains(time_temp)) &&
                        (cageBath2.contains(time_temp) ||
                            cageFeed2.contains(time_temp))) {
                      Fluttertoast.showToast(
                          msg: "TIME ALREADY SCHEDULED",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          fontSize: 20.0);
                    } else if (cageBath1.contains(time_temp) ||
                        cageFeed1.contains(time_temp)) {
                      Fluttertoast.showToast(
                          msg: "CAGE1 TIME ALREADY SCHEDULED",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          fontSize: 20.0);
                      sched2(time_temp);
                      cage2_id++;
                      setState(() {
                        isCheck2 = false;
                      });
                    } else if ((cageBath2.contains(time_temp) ||
                        cageFeed2.contains(time_temp))) {
                      Fluttertoast.showToast(
                          msg: "CAGE2 TIME ALREADY SCHEDULED",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          fontSize: 20.0);
                      sched1(time_temp);
                      cage1_id++;
                      setState(() {
                        isCheck = false;
                      });
                    } else {
                      sched1(time_temp);
                      cage1_id++;
                      sched2(time_temp);
                      cage2_id++;
                      setState(() {
                        isCheck2 = false;
                        isCheck = false;
                      });
                    }

                    // sched1(time_temp);
                    // sched2(time_temp);
                    // cage1_id++;
                    // cage2_id++;
                    // setState(() {
                    //   isCheck = false;
                    //   isCheck2 = false;
                    // });
                  } else if (isCheck == true && isCheck2 == false) {
                    if (cageBath1.contains(time_temp) ||
                        cageFeed1.contains(time_temp)) {
                      Fluttertoast.showToast(
                          msg: "TIME ALREADY SCHEDULED",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          fontSize: 20.0);
                    } else {
                      sched1(time_temp);
                      cage1_id++;
                      setState(() {
                        isCheck = false;
                      });
                    }

                    // sched1(time_temp);
                    // cage1_id++;
                    // setState(() {
                    //   isCheck = false;
                    // });
                  } else if (isCheck == false && isCheck2 == true) {
                    if (cageBath2.contains(time_temp) ||
                        cageFeed2.contains(time_temp)) {
                      Fluttertoast.showToast(
                          msg: "TIME ALREADY SCHEDULED",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          fontSize: 20.0);
                    } else {
                      sched2(time_temp);
                      cage2_id++;
                      setState(() {
                        isCheck2 = false;
                      });
                    }
                    // sched2(time_temp);
                    // cage2_id++;
                    // setState(() {
                    //   isCheck2 = false;
                    // });
                  } else if (isCheck == false && isCheck2 == false) {
                    Fluttertoast.showToast(
                        msg: "SELECT TIME AND CAGE",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        fontSize: 20.0);
                  }

                  if (cage1_id == 3 && cage2_id == 3) {
                    for (int i = 0; i <= 2; i++) {
                      await getTime_C1(i.toString());
                      await getTime_C2(i.toString());
                      if (i == 2) {
                        for (int i = 0; i <= 2; i++) {
                          await postUpdated_C1(cageTime1[i]);
                          await postUpdated_C2(cageTime2[i]);
                          cage1_key++;
                          cage2_key++;
                        }
                      }
                    }
                    cage1_id++;
                    cage2_id++;
                  } else if (cage1_id == 3) {
                    for (int i = 0; i <= 2; i++) {
                      await getTime_C1(i.toString());
                      if (i == 2) {
                        for (int i = 0; i <= 2; i++) {
                          await postUpdated_C1(cageTime1[i]);
                          cage1_key++;
                        }
                      }
                    }
                    cage1_id++;
                  } else if (cage2_id == 3) {
                    for (int i = 0; i <= 2; i++) {
                      await getTime_C2(i.toString());
                      if (i == 2) {
                        for (int i = 0; i <= 2; i++) {
                          await postUpdated_C2(cageTime2[i]);
                          cage2_key++;
                        }
                      }
                    }
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

  Future<void> postUpdated_C1(String time) async {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage1_wash_sched");

    await _testRef.update({cage1_key.toString(): time});
  }

  Future<void> postUpdated_C2(String time) async {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage2_wash_sched");

    await _testRef.update({cage2_key.toString(): time});
  }

  sched1(String cage1) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage1_wash_sched");

    _testRef.update({cage1_id.toString(): cage1});
  }

  sched2(String cage2) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("/cage2_wash_sched");
    _testRef.update({cage2_id.toString(): cage2});
  }

  void empty(BuildContext context) {
    var alertDialog = const AlertDialog(
        title: Text("ALERT"), content: Text("Please SET TIME and choose CAGE"));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
