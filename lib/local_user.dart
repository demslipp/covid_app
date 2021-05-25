import 'package:covid_app/tools.dart';
import 'package:intl/intl.dart';

class LocalUser {
  String surname;
  String firstname;
  String country;
  String city;
  DateTime date;
  final format = DateFormat("yyyy-MM-dd");

  LocalUser({
    this.surname,
    this.firstname,
    this.date,
    this.country,
    this.city,
  });

  static LocalUser randomLocalUser() {
    return LocalUser(
        firstname: Tools.getRandomString(5),
        surname: Tools.getRandomString(5),
        date: DateTime.now(),
        country: Tools.getRandomString(5),
        city: Tools.getRandomString(5)
    );
  }
}