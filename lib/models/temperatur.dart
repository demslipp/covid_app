import 'package:covid_app/tools.dart';
import 'package:intl/intl.dart';

class Temperature {
  String value;
  DateTime date;
  final format = DateFormat("dd-MM-yyyy");

  Temperature({
    this.value,
    this.date,
  });

  static Temperature randomLocalUser() {
    return Temperature(value: Tools.getRandomString(3), date: DateTime.now());
  }
}
