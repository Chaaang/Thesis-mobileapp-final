class Log {
  String event;
  String type;
  String date;
  String time;
  String status;

  Log(this.event, this.type, this.time, this.date, this.status);

  factory Log.fromDb(dynamic data) {
    List<String> info = (data as String).split("|");
    //print(info);
    return Log(info[0], info[1], info[2], info[3], info[4]);
  }
}
