import 'package:json_annotation/json_annotation.dart';

part 'country_name.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryName {
  final String common;
  final String official;

  CountryName({
    required this.common,
    required this.official,
  });

  factory CountryName.fromJson(Map<String, dynamic> json) => _$CountryNameFromJson(json);
  Map<String, dynamic> toJson() => _$CountryNameToJson(this);
}