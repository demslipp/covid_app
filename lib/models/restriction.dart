part 'restriction.g.dart';

class Restriction {
  Restriction(this.name, this.status, this.quarantineIn, this.quarantineOut,
      this.vaccineAcceptance);

  String name;
  Status status;
  Possibility quarantineIn;
  Possibility quarantineOut;
  bool vaccineAcceptance;

  factory Restriction.fromJson(Map<String, dynamic> json) =>
      _$RestrictionFromJson(json);
  Map<String, dynamic> toJson() => _$RestrictionToJson(this);
}

enum Status { HIGH, MIDDLE, LOW }

enum Possibility { YES, NO, MAYBE }
