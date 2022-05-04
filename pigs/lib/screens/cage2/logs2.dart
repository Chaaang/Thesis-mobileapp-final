import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pigs/models/log.dart';

class C2Logs extends StatefulWidget {
  const C2Logs({Key? key}) : super(key: key);

  @override
  State<C2Logs> createState() => _C2LogsState();
}

class _C2LogsState extends State<C2Logs> {
  Future<List<Log>> _getLogs() async {
    final snapshot = await FirebaseDatabase.instance.ref("cage_2/logs").get();

    final data =
        snapshot.children.toList().map((e) => Log.fromDb(e.value)).toList();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Logs"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _getLogs(),
            builder: (context, AsyncSnapshot<List<Log>> snapshot) {
              final connection =
                  snapshot.connectionState == ConnectionState.done;
              if (connection && snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialogFunction(
                              context,
                              snapshot.data![index].event,
                              snapshot.data![index].type,
                              snapshot.data![index].time,
                              snapshot.data![index].date,
                              snapshot.data![index].status);
                        },
                        child: Card(
                          child: ListTile(
                              title: Text(snapshot.data![index].event,
                                  style: TextStyle(fontSize: 25)),
                              subtitle: Text(
                                "Type: " +
                                    snapshot.data![index].type +
                                    "\nTime: " +
                                    snapshot.data![index].time +
                                    "\nDate: " +
                                    snapshot.data![index].date +
                                    "\nStatus: " +
                                    snapshot.data![index].status,
                                style: TextStyle(fontSize: 20),
                              )),
                          color: Colors.blueGrey,
                          elevation: 8,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 1)),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  showDialogFunction(context, event, type, time, date, status) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      event,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Type: " +
                          type +
                          "\n" +
                          "Time: " +
                          time +
                          "\n" +
                          "Date: " +
                          date,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    Text("Status: " + status,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
