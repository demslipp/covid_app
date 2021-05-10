import 'package:intl/intl.dart';

class User {
  String surname;
  String firstname;
  String country;
  String city;
  DateTime date;
  final format = DateFormat("yyyy-MM-dd");

  User({
    this.surname,
    this.firstname,
    this.date,
    this.country,
    this.city,
  });
}
