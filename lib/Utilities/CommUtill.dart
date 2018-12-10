import 'package:intl/intl.dart';

class CommUtill {
  static String timestampToDate(int timeStamp) {
    print(timeStamp);
    var date = new DateTime.fromMillisecondsSinceEpoch(timeStamp*1000);
    print(date);
    return new DateFormat.EEEE().format(date);
  }
}
