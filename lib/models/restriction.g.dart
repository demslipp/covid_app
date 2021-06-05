// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restriction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restriction _$RestrictionFromJson(Map<String, dynamic> json) {
  return Restriction(
    json['name'] as String,
    _$enumDecode(_$StatusEnumMap, json['status']),
    _$enumDecode(_$PossibilityEnumMap, json['quarantineIn']),
    _$enumDecode(_$PossibilityEnumMap, json['quarantineOut']),
    json['vaccineAcceptance'] as bool,
  );
}

Map<String, dynamic> _$RestrictionToJson(Restriction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': _$StatusEnumMap[instance.status],
      'quarantineIn': _$PossibilityEnumMap[instance.quarantineIn],
      'quarantineOut': _$PossibilityEnumMap[instance.quarantineOut],
      'vaccineAcceptance': instance.vaccineAcceptance,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object source, {
  K unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$StatusEnumMap = {
  Status.HIGH: 'HIGH',
  Status.MIDDLE: 'MIDDLE',
  Status.LOW: 'LOW',
};

const _$PossibilityEnumMap = {
  Possibility.YES: 'YES',
  Possibility.NO: 'NO',
  Possibility.MAYBE: 'MAYBE',
};
