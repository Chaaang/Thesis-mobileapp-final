import 'package:flutter/material.dart';
import 'package:pigs/screens/cage1/feed1.dart';
import 'package:pigs/screens/cage1/logs1.dart';
import 'package:pigs/screens/cage1/tank1.dart';
import 'package:pigs/screens/cage1/sanitation2.dart';

class Cage1 extends StatelessWidget {
  const Cage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAGE1'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(45),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Feed()));
                  },
                  child: const Text('FEED', style: TextStyle(fontSize: 35)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size(300, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
            ),
            Container(
              margin: const EdgeInsets.all(45),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Washing1()));
                  },
                  child:
                      const Text('SANITATION', style: TextStyle(fontSize: 35)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size(300, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
            ),
            Container(
              margin: const EdgeInsets.all(45),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => tanks1()));
                  },
                  child: const Text('TANK', style: TextStyle(fontSize: 35)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size(300, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
            ),
            Container(
              margin: const EdgeInsets.all(45),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => C1Logs()));
                  },
                  child: const Text('LOGS', style: TextStyle(fontSize: 35)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size(300, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
            ),
          ],
        ),
      ),
    );
  }
}
