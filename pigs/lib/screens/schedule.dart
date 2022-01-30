import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime dateTime = DateTime(2022);
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
            Text(
              "${dateTime.day}-${dateTime.month}-${dateTime.year}",
              style: const TextStyle(fontSize: 50),
            ),
            ElevatedButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dateTime,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2050));
                  if (newDate != null) {
                    setState(() {
                      dateTime = newDate;
                      print(dateTime);
                    });
                  }
                },
                child: const Text("Choose Date"))
          ],
        ),
      ),
    );
  }
}
