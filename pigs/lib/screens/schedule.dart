import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime dateTime = DateTime(2022);
  TimeOfDay timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  void date() {
    showDatePicker(
            context: context,
            initialDate: dateTime,
            firstDate: DateTime(2022),
            lastDate: DateTime(2050))
        .then((value) => {
              setState(() {
                dateTime = value!;
              })
            });
  }

  void time() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {
              setState(() {
                timeOfDay = value!;
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
            Text('${dateTime.day}-${dateTime.month}-${dateTime.year}'),
            ElevatedButton(
                onPressed: () {
                  date();
                },
                child: const Text("Choose Date")),
            Text(timeOfDay.format(context).toString()),
            ElevatedButton(
                onPressed: () {
                  time();
                },
                child: const Text("Choose Time"))
          ],
        ),
      ),
    );
  }
}
