import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pigs/screens/home.dart';
import 'package:pigs/screens/schedules.dart';
import 'package:pigs/screens/settings.dart';
import 'image_banner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const HomeScreen(
        title: 'Home',
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text("Settings")),
                    const PopupMenuItem<int>(
                        value: 2, child: Text("Contact Us")),
                  ])
        ],
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(17.0),
          child: ClipOval(child: ImageBanner("assets/images/cover.jpg")),
        ),
        const Home(),
      ]),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
    }
  }
}
