import 'package:flutter/material.dart';
import 'package:pigs/screens/cage1/cage1.dart';
import 'package:pigs/screens/cage2/cage2.dart';
import 'package:pigs/screens/tanks.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(45),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Cage1()));
                },
                child: const Text(
                  'CAGE 1',
                  style: TextStyle(fontSize: 35),
                ),
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
                      MaterialPageRoute(builder: (context) => const Cage2()));
                },
                child: const Text('CAGE 2', style: TextStyle(fontSize: 35)),
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
                      MaterialPageRoute(builder: (context) => tanks()));
                },
                child: const Text('TANKS', style: TextStyle(fontSize: 35)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    fixedSize: const Size(300, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
          )
        ],
      ),
    );
  }
}
