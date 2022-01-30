import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final items = ['1kg', '2kg', '3kg'];
  var temp;
  var temp2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("CAGE 1"),
                const SizedBox(width: 30),
                DropdownButton<String>(
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: temp,
                    hint: const Text("Select Weight"),
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                          temp = value;
                          //weight(temp);
                        })),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("CAGE 2"),
                const SizedBox(width: 30),
                DropdownButton<String>(
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: temp2,
                    hint: const Text("Select Weight"),
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                          temp2 = value;
                          // weight(temp2);
                        })),
              ],
            ),
            ElevatedButton(
              child: const Text(
                "SET",
                style: TextStyle(fontSize: 35),
              ),
              onPressed: () {
                if (temp == null && temp2 == null) {
                  notset(context);
                } else if (temp == null) {
                  weight2(temp2);
                  allset(context);
                } else if (temp2 == null) {
                  weight(temp);
                  allset(context);
                } else {
                  weight(temp);
                  weight2(temp2);
                  allset(context);
                }
                // if (temp == null) {
                //   weight2(temp2);
                //   allset(context);
                // } else if (temp2 == null) {
                //   weight(temp);
                //   allset(context);
                // } else if (temp == null && temp2 == null) {
                //   notset(context);
                // }
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  fixedSize: const Size(300, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
  weight(var dataweight) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref("/cage_1");
    _testRef.update({'weight_1': dataweight});
  }

  weight2(var dataweight) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref("/cage_2");
    _testRef.update({'weight_2': dataweight});
  }

  void allset(BuildContext context) {
    var alertDialog = const AlertDialog(
        title: Text("DONE"), content: Text("You may feed your pigs!"));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void notset(BuildContext context) {
    var alertDialog = const AlertDialog(
        title: Text("ALERT"), content: Text("Please SET atleast 1 cage"));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
