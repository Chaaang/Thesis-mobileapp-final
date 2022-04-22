import 'package:flutter/material.dart';

import 'package:pigs/screens/cage2/feed2.dart';
import 'package:pigs/screens/cage2/tank2.dart';
import 'package:pigs/screens/cage2/wash2.dart';

class Cage2 extends StatelessWidget {
  const Cage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAGE2'),
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
                        MaterialPageRoute(builder: (context) => Feed2()));
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
                        MaterialPageRoute(builder: (context) => Washing2()));
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
                        MaterialPageRoute(builder: (context) => tanks2()));
                  },
                  child: const Text('TANKS', style: TextStyle(fontSize: 35)),
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
