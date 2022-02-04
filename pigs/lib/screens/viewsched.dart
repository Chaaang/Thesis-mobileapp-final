import 'package:flutter/material.dart';

class ViewSched extends StatefulWidget {
  const ViewSched({Key? key}) : super(key: key);

  @override
  _ViewSchedState createState() => _ViewSchedState();
}

class _ViewSchedState extends State<ViewSched> {
  @override
  Widget build(BuildContext context) {
    // TableRow _tableRow = const TableRow(children: <Widget>[
    //   Padding(padding: EdgeInsets.all(10.0), child: Text('Cell 1')),
    //   Padding(padding: EdgeInsets.all(10.0), child: Text('Cell 2')),
    // ]);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Schedule"),
        ),
        body: ListView(
          children: [_DataTable()],
        ));
  }

  DataTable _DataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('FEED')),
      DataColumn(label: Text('WASH')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
      ])
    ];
  }
}
