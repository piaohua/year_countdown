import 'package:scoped_model/scoped_model.dart';

class Life extends Model {
  int life = _thisYearOfDays();
  //String _key;

  Life(String key) {
    //this._key = key;
  }

  int remainingDays() {
    return _remainingDays();
  }

  // 今年过去天数
  int pastDays() {
    return life - _remainingDays();
  }

  // 今年剩余天数
  static int _remainingDays() {
    DateTime now = new DateTime.now();
    int year = now.year;
    DateTime lastDay = new DateTime(year, DateTime.december, 31);
    Duration difference = lastDay.difference(now);
    return difference.inDays;
  }

  // 今年的总天数
  static int _thisYearOfDays() {
    int year = DateTime.now().year;
    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
      return 366; //闰年
    }
    return 365; //平年
  }
}
